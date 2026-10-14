return {
	General = {
		name = 'Shop',
		blip = {
			id = 59, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'burger', price = 10 },
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
		}, targets = {
			-- shopkeepers (positions to check in game)
			{ loc = vec3(24.47, -1346.62, 29.5), heading = 271.66, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(-3039.54, 584.38, 7.91), heading = 17.27, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(-3242.97, 1000.01, 12.83), heading = 357.57, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(1728.07, 6415.63, 35.04), heading = 242.95, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(1697.96, 4923.04, 42.06), heading = 326.16, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(1959.82, 3740.48, 32.34), heading = 301.57, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(549.13, 2670.85, 42.16), heading = 99.39, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(2677.47, 3279.76, 55.24), heading = 335.08, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(2556.66, 380.84, 108.62), heading = 356.67, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(372.66, 326.98, 103.57), heading = 253.73, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
		}
	},

	Liquor = {
		name = 'Liquor Store',
		blip = {
			id = 93, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'burger', price = 15 },
		}, locations = {
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319)
		}, targets = {
			-- shopkeepers (positions to check in game)
			{ loc = vec3(1134.2, -982.91, 46.42), heading = 277.24, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(-1221.58, -908.15, 12.33), heading = 35.49, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(-1486.59, -377.68, 40.16), heading = 139.51, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(-2966.39, 391.42, 15.04), heading = 87.48, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(1165.17, 2710.88, 38.16), heading = 179.43, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
			{ loc = vec3(1392.0, 3606.0, 34.98), heading = 201.0, ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', distance = 2.5 },
		}
	},

	YouTool = {
		name = 'YouTool',
		blip = {
			id = 402, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'lockpick', price = 10 }
		}, locations = {
			vec3(2748.0, 3473.0, 55.67),
			vec3(342.99, -1298.26, 32.51)
		}, targets = {
			{ loc = vec3(2746.8, 3473.13, 55.67), length = 0.6, width = 3.0, heading = 65.0, minZ = 55.0, maxZ = 56.8, distance = 3.0 }
		}
	},

	Ammunation = {
		name = 'Ammunation',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'ammo-9', price = 5, },
			{ name = 'WEAPON_KNIFE', price = 200 },
			{ name = 'WEAPON_BAT', price = 100 },
			{ name = 'WEAPON_PISTOL', price = 1000, metadata = { registered = true }, license = 'weapon' }
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
			{ loc = vec3(-660.92, -934.10, 21.94), length = 0.6, width = 0.5, heading = 180.0, minZ = 21.8, maxZ = 22.2, distance = 2.0 },
			{ loc = vec3(808.86, -2158.50, 29.73), length = 0.6, width = 0.5, heading = 360.0, minZ = 29.6, maxZ = 30.0, distance = 2.0 },
			{ loc = vec3(1693.57, 3761.60, 34.82), length = 0.6, width = 0.5, heading = 227.39, minZ = 34.7, maxZ = 35.1, distance = 2.0 },
			{ loc = vec3(-330.29, 6085.54, 31.57), length = 0.6, width = 0.5, heading = 225.0, minZ = 31.4, maxZ = 31.8, distance = 2.0 },
			{ loc = vec3(252.85, -51.62, 70.0), length = 0.6, width = 0.5, heading = 70.0, minZ = 69.9, maxZ = 70.3, distance = 2.0 },
			{ loc = vec3(23.68, -1106.46, 29.91), length = 0.6, width = 0.5, heading = 160.0, minZ = 29.8, maxZ = 30.2, distance = 2.0 },
			{ loc = vec3(2566.59, 293.13, 108.85), length = 0.6, width = 0.5, heading = 360.0, minZ = 108.7, maxZ = 109.1, distance = 2.0 },
			{ loc = vec3(-1117.61, 2700.26, 18.67), length = 0.6, width = 0.5, heading = 221.82, minZ = 18.5, maxZ = 18.9, distance = 2.0 },
			{ loc = vec3(841.05, -1034.76, 28.31), length = 0.6, width = 0.5, heading = 360.0, minZ = 28.2, maxZ = 28.6, distance = 2.0 }
		}
	},

	PoliceArmoury = {
		name = 'Police Armoury',
		groups = shared.police,
		blip = {
			id = 110, colour = 84, scale = 0.8
		}, inventory = {
			{ name = 'ammo-9', price = 5, },
			{ name = 'ammo-rifle', price = 5, },
			{ name = 'WEAPON_FLASHLIGHT', price = 200 },
			{ name = 'WEAPON_NIGHTSTICK', price = 100 },
			{ name = 'WEAPON_PISTOL', price = 500, metadata = { registered = true, serial = 'POL' }, license = 'weapon' },
			{ name = 'WEAPON_CARBINERIFLE', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 3 },
			{ name = 'WEAPON_STUNGUN', price = 500, metadata = { registered = true, serial = 'POL'} }
		}, locations = {
			vec3(451.51, -979.44, 30.68)
		}, targets = {
			{ loc = vec3(453.21, -980.03, 30.68), length = 0.5, width = 3.0, heading = 270.0, minZ = 30.5, maxZ = 32.0, distance = 6 }
		}
	},

	Medicine = {
		name = 'Medicine Cabinet',
		groups = {
			['ambulance'] = 0
		},
		blip = {
			id = 403, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'medikit', price = 26 },
			{ name = 'bandage', price = 5 }
		}, locations = {
			vec3(306.3687, -601.5139, 43.28406)
		}, targets = {

		}
	},

	BlackMarketArms = {
		name = 'Black Market (Arms)',
		inventory = {
			{ name = 'WEAPON_DAGGER', price = 5000, metadata = { registered = false	}, currency = 'black_money' },
			{ name = 'WEAPON_CERAMICPISTOL', price = 50000, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'at_suppressor_light', price = 50000, currency = 'black_money' },
			{ name = 'ammo-rifle', price = 1000, currency = 'black_money' },
			{ name = 'ammo-rifle2', price = 1000, currency = 'black_money' }
		}, locations = {
			vec3(309.09, -913.75, 56.46)
		}, targets = {

		}
	},

	VendingMachineDrinks = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
		}
	}
}
