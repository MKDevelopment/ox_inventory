---Target bridge: tgiann-target exposes the ox_target API, so both are driven the same way.
---data/stores.lua `target`: 'auto' (tgiann-target when started, else ox_target), 'ox_target' or 'tgiann-target'.
local config = lib.load('data.stores') or {}

local Target = {}

---@return string? resource
local function getResource()
	local mode = config.target or 'auto'

	if mode ~= 'ox_target' and GetResourceState('tgiann-target') == 'started' then return 'tgiann-target' end
	if mode ~= 'tgiann-target' and GetResourceState('ox_target') == 'started' then return 'ox_target' end
end

---@return boolean
function Target.available()
	return getResource() ~= nil
end

---@param entity number local entity handle
---@param options table[]
function Target.addLocalEntity(entity, options)
	local resource = getResource()
	if resource then exports[resource]:addLocalEntity(entity, options) end
end

---@param entity number
---@param names? string | string[]
function Target.removeLocalEntity(entity, names)
	local resource = getResource()
	if resource then exports[resource]:removeLocalEntity(entity, names) end
end

return Target
