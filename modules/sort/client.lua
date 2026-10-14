if not lib then return end

RegisterNUICallback('sortInventory', function(mode, cb)
	cb(1)

	local success, reason = lib.callback.await('ox_inventory:sortInventory', false, mode)

	if not success and reason then
		lib.notify({ type = 'error', description = locale(reason) })
	end
end)
