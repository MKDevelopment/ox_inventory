if not lib then return end

local Inventory = require 'modules.inventory.server'
local Items = require 'modules.items.server'

local config = lib.load('data.metadata') or {}
local editing = config.editing or {}
local denied = {}

for _, name in ipairs(editing.deny or {}) do
	denied[name] = true
end

---Whole number from NUI/JSON input (which may arrive as 5.0), or nil.
---@param value any
---@return integer?
local function toInt(value)
	value = tonumber(value)
	if value and value == math.floor(value) and value > -2^31 and value < 2^31 then return math.tointeger(value) end
end

local charset = '0123456789ABCDEFGHJKLMNPQRSTUVWXYZ'

local function randomCode(length)
	local code = {}

	for i = 1, length do
		local index = math.random(1, #charset)
		code[i] = charset:sub(index, index)
	end

	return table.concat(code)
end

---@param value any template value
---@return any
local function resolveTemplate(value)
	if type(value) == 'table' and #value == 2 then
		return math.random(math.floor(value[1]), math.floor(value[2]))
	elseif value == 'date' then
		return os.date('%d.%m.%Y')
	elseif value == 'serial' then
		return randomCode(6)
	end

	return value
end

-- Fill template metadata for newly created items.
exports.ox_inventory:registerHook('createItem', function(payload)
	local item = payload.item
	local template = item and Items(item.name)?.template

	if type(template) ~= 'table' then return end

	local metadata = payload.metadata or {}

	for key, value in pairs(template) do
		if metadata[key] == nil then
			metadata[key] = resolveTemplate(value)
		end
	end

	return metadata
end)

---Keeps printable characters only; tooltips render values as plain text but labels are reused elsewhere.
---@param value string
---@param maxLength number
---@return string
local function sanitize(value, maxLength)
	value = value:gsub('%c', ' '):gsub('[<>]', ''):gsub('%s+', ' ')
	value = value:match('^%s*(.-)%s*$')

	if utf8.len(value) and utf8.len(value) > maxLength then
		value = value:sub(1, utf8.offset(value, maxLength + 1) - 1)
	end

	return value
end

local limits = {
	label = editing.labelLength or 32,
	note = editing.noteLength or 120,
}

local cooldowns = {}

AddEventHandler('playerDropped', function()
	cooldowns[source] = nil
end)

lib.callback.register('ox_inventory:editItemMetadata', function(source, slotId, field, value)
	local maxLength = limits[field]

	slotId = toInt(slotId)

	if not maxLength or not slotId or type(value) ~= 'string' or #value > maxLength * 4 then
		return false
	end

	local now = GetGameTimer()
	if cooldowns[source] and now - cooldowns[source] < (editing.cooldown or 2000) then return false end
	cooldowns[source] = now

	local inv = Inventory(source) --[[@as OxInventory?]]
	if not inv?.player or Player(source).state.invBusy then return false end

	local slot = inv.items[slotId]
	if not slot then return false end
	if denied[slot.name] then return false, 'metadata_locked' end

	value = sanitize(value, maxLength)

	local metadata = table.clone(slot.metadata)

	if field == 'label' then
		if value == '' then
			-- restore whatever label the item had before it was renamed
			metadata.label = metadata.baseLabel
			metadata.baseLabel = nil
			metadata.renamed = nil
		else
			if not metadata.renamed then metadata.baseLabel = metadata.label end
			metadata.label = value
			metadata.renamed = true
		end
	else
		metadata.note = value ~= '' and value or nil
	end

	Inventory.SetMetadata(inv, slotId, metadata)
	lib.logger(inv.owner, 'editItemMetadata', ('set %s of %s (slot %d) to "%s"'):format(field, slot.name, slotId, value))

	return true
end)
