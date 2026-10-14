if not lib then return end

local config = lib.load('data.metadata') or {}

if config.display then
	-- the export is registered by modules/items/client, which loads after this module
	CreateThread(function()
		local labels = {}

		for i = 1, #config.display do
			local key = config.display[i]
			labels[i] = { [key] = locale(('meta_%s'):format(key)) }
		end

		exports[shared.resource]:displayMetadata(labels)
	end)
end

RegisterNUICallback('editItemMetadata', function(data, cb)
	cb(1)

	local success, reason = lib.callback.await('ox_inventory:editItemMetadata', false, data.slot, data.field, data.value)

	if not success and reason then
		lib.notify({ type = 'error', description = locale(reason) })
	end
end)
