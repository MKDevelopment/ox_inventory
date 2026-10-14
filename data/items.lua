-- Item catalog for MyStoryRP, grouped by category.
-- category: inventory folder (weapons, food, drinks, ingredients, medical, drugs, vehicle, tools,
--           documents, valuables, materials, clothing, other)
-- tier:     caps how full food and drinks can make you (see data/food.lua); needs client.status
-- images:   <inventory:imagepath>/<item name>.<inventory:imageformat> unless client.image is set
return {
	-- Weapons and ammunition (4)
	['knife'] = {
		label = 'Knife',
		description = 'For cutting paintings out of their frames. Wears down on every cut.',
		category = 'weapons',
		weight = 200,
		stack = false,
		close = true,
	},

	['police_stormram'] = {
		label = 'Stormram',
		description = 'A nice tool to break into doors',
		category = 'weapons',
		weight = 18000,
		stack = true,
		close = true,
		client = {
			image = 'police_stormram.png',
		},
	},

	['police_stungun_ammo'] = {
		label = 'Pollice Stungun ammo',
		description = 'Ammo for Stungun',
		category = 'weapons',
		weight = 200,
		stack = true,
		close = true,
	},

	['stungun_ammo'] = {
		label = 'Stungun ammo',
		description = 'Ammo for Stungun',
		category = 'weapons',
		weight = 200,
		stack = true,
		close = true,
	},

	-- Food (340)
	['avosushi'] = {
		label = 'Avokado Sushi',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['bacon_egg_cheese_bagel'] = {
		label = 'Patırma, Yumurta ve Peynirli Simit',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['baklava_fork'] = {
		label = 'Baklava with Fork',
		description = 'A single square of pistachio baklava with a fork resting beside it.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['banana_macaroon'] = {
		label = 'Banana Macaroon',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['banana_muffin'] = {
		label = 'Banana muffin',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['beef_kebab'] = {
		label = 'Beef Kebap',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['beef_ramen'] = {
		label = 'Beef Ramen',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['beeftaco'] = {
		label = 'Beef Taco',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['bento'] = {
		label = 'Bento Box',
		description = '',
		category = 'food',
		weight = 500,
		stack = false,
		close = true,
	},

	['berry_cheesecake'] = {
		label = 'Berry Cheesecake',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['berry_icecream'] = {
		label = 'Berry Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['berry_muffin'] = {
		label = 'Berry muffin',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['blueberry_donut'] = {
		label = 'Blueberry Donut',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['blueberry_macaroon'] = {
		label = 'Blueberry Macaroon',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['bmochi'] = {
		label = 'Blue Mochi',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['borek_kiymali_single'] = {
		label = 'Minced Meat Börek Slice',
		description = 'One warm slice of layered börek filled with seasoned minced beef.',
		category = 'food',
		weight = 150,
		stack = true,
		close = true,
	},

	['borek_patatesli_single'] = {
		label = 'Potato Börek Slice',
		description = 'One warm slice of layered börek filled with spiced mashed potato.',
		category = 'food',
		weight = 150,
		stack = true,
		close = true,
	},

	['borek_peynirli_single'] = {
		label = 'Cheese Börek Slice',
		description = 'One warm slice of layered börek filled with white cheese and parsley.',
		category = 'food',
		weight = 150,
		stack = true,
		close = true,
	},

	['bowl_ramen_miso'] = {
		label = 'Miso Ramen',
		description = 'Wheat noodles in fermented soybean broth with egg, nori and toppings.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['bowl_ramen_shio'] = {
		label = 'Shio Ramen',
		description = 'Wheat noodles in clear salt broth with egg, nori and toppings.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['bowl_ramen_shoyu'] = {
		label = 'Shoyu Ramen',
		description = 'Wheat noodles in soy-based broth with egg, nori and toppings.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['bowl_ramen_spicy'] = {
		label = 'Spicy Ramen',
		description = 'Wheat noodles in chilli-fired broth with egg, nori and toppings.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['bowl_ramen_tonkotsu'] = {
		label = 'Tonkotsu Ramen',
		description = 'Wheat noodles in milky pork bone broth with egg, nori and toppings.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['bowl_soup_brokoli'] = {
		label = 'Broccoli Soup',
		description = 'A hot bowl of broccoli soup. Warms you from the inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['bowl_soup_domates'] = {
		label = 'Tomato Soup',
		description = 'A hot bowl of tomato soup. Warms you from the inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['bowl_soup_ezogelin'] = {
		label = 'Ezogelin Soup',
		description = 'A hot bowl of ezogelin soup. Warms you from the inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['bowl_soup_havuc'] = {
		label = 'Carrot Soup',
		description = 'A hot bowl of carrot soup. Warms you from the inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['bowl_soup_lahana'] = {
		label = 'Cabbage Soup',
		description = 'A hot bowl of cabbage soup. Warms you from the inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['bowl_soup_mantar'] = {
		label = 'Mushroom Soup',
		description = 'A hot bowl of mushroom soup. Warms you from the inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['bowl_soup_mercimek'] = {
		label = 'Lentil Soup',
		description = 'A hot bowl of lentil soup. Warms you from the inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['bowl_soup_miso'] = {
		label = 'Miso Soup',
		description = 'A hot bowl of miso soup. Warms you from the inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['bowl_soup_tarhana'] = {
		label = 'Tarhana Soup',
		description = 'A hot bowl of tarhana soup. Warms you from the inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['bowl_soup_yogurt'] = {
		label = 'Yoghurt Soup',
		description = 'A hot bowl of yoghurt soup. Warms you from the inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['bowl_sutlac'] = {
		label = 'Rice Pudding',
		description = 'Oven-baked rice pudding with a scorched cinnamon top.',
		category = 'food',
		weight = 300,
		stack = true,
		close = true,
	},

	['bread'] = {
		label = 'Bread',
		description = '',
		category = 'food',
		tier = 'snack',
		weight = 100,
		stack = true,
		close = true,
		consume = 1,
		client = {
			status = { hunger = 200000 },
			anim = { clip = 'mp_player_int_eat_burger', dict = 'mp_player_inteat@burger' },
			prop = {
				bone = 60309,
				model = 'prop_cs_burger_01',
				pos = vec3(0.0, 0.0, -0.01999999955296),
				rot = vec3(30.0, 0.0, 0.0),
			},
			usetime = 2500,
		},
	},

	['brownie_cocoa'] = {
		label = 'Cocoa Brownie',
		description = 'Dense fudgy brownie studded with dark cocoa.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['brownie_coconut'] = {
		label = 'Coconut Brownie',
		description = 'Dense fudgy brownie studded with toasted coconut.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['brownie_fruit'] = {
		label = 'Fruit Brownie',
		description = 'Dense fudgy brownie studded with candied fruit.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['brownie_white_choco'] = {
		label = 'White Chocolate Brownie',
		description = 'Dense fudgy brownie studded with white chocolate chunks.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['bubblegum_icecream'] = {
		label = 'Bubblegum Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['burger'] = {
		label = 'Burger',
		category = 'food',
		tier = 'fastfood',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger',
		},
	},

	['burger_2x'] = {
		label = 'Double Hamburger',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['burger_3x'] = {
		label = 'Tripple Hamburger',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['burger_4x'] = {
		label = 'Stack Hamburger',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['burger_beef'] = {
		label = 'Beef Burger',
		description = 'A grilled beef patty with lettuce, tomato and sauce.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['burger_beef_double'] = {
		label = 'Double Beef Burger',
		description = 'Two stacked beef patties. Bring an appetite.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['burger_cheese'] = {
		label = 'Cheeseburger',
		description = 'Beef patty smothered in melted cheddar.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['burger_chicken'] = {
		label = 'Chicken Burger',
		description = 'Crispy chicken fillet with fresh salad and mayo.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
		client = { image = 'burger_chicken.png' },
	},

	['burger_veggie'] = {
		label = 'Veggie Burger',
		description = 'Grilled vegetable patty with greens and sauce.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['caramel_icecream'] = {
		label = 'Caramel Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['cheeseburger'] = {
		label = 'Cheese Burger',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['cherry_donut'] = {
		label = 'Cherry Donut',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['chicken_kebab'] = {
		label = 'Chicken Kebap',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['chicken_noodle_soup'] = {
		label = 'Chicken noodle Soup',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['chicken_nugget'] = {
		label = 'Chicken Nugget',
		description = 'A single crispy breaded chicken nugget.',
		category = 'food',
		weight = 40,
		stack = true,
		close = true,
	},

	['chicken_nugget_pack'] = {
		label = 'Chicken Nuggets',
		description = 'A box of golden chicken nuggets, still steaming.',
		category = 'food',
		weight = 250,
		stack = true,
		close = true,
	},

	['chicken_ramen'] = {
		label = 'Chicken Ramen',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['chicken_wing'] = {
		label = 'Chicken Wing',
		description = 'One fried chicken wing, still glistening.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['chicken_wing_pack'] = {
		label = 'Chicken Wings',
		description = 'A tray of roasted chicken wings with a sticky glaze.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['chickenburger'] = {
		label = 'Chicken Burger',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['chickenpizza'] = {
		label = 'Chicken Pizza',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['chickentaco'] = {
		label = 'Chicken Taco',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['chocolate'] = {
		label = 'Chocolate',
		description = '',
		category = 'food',
		weight = 100,
		stack = true,
		close = true,
	},

	['chocolate_cake'] = {
		label = 'Chocolate Cake',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['chocolate_cheesecake'] = {
		label = 'White Chocolate Cheesecake',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['chocolate_donut'] = {
		label = 'Chocolate Donut',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['chocolate_icecream'] = {
		label = 'Chocolate Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['chocolate_strawberry_icecream'] = {
		label = 'Strawberry&Chocolate Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['cig_kofte_wrap'] = {
		label = 'Cig Kofte Wrap',
		description = 'Spiced bulgur kofte rolled in lavash with lettuce, pomegranate sauce and lemon.',
		category = 'food',
		weight = 220,
		stack = true,
		close = true,
	},

	['classic_brownies'] = {
		label = 'Brownie',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['cookie_blueberry'] = {
		label = 'Blueberry Cookie',
		description = 'Chewy cookie packed with dried blueberries.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['cookie_choco'] = {
		label = 'Chocolate Cookie',
		description = 'Chewy cookie packed with chocolate chips.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['cookie_double_choco'] = {
		label = 'Double Chocolate Cookie',
		description = 'Chewy cookie packed with cocoa dough and chocolate chunks.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['cookie_white_choco'] = {
		label = 'White Chocolate Cookie',
		description = 'Chewy cookie packed with white chocolate chips.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['creamy_chicken_soup'] = {
		label = 'Creamy Chicken Soup',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['creme_donut'] = {
		label = 'Cream Donut',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['doner_half'] = {
		label = 'Döner in Bread',
		description = 'Half a round flatbread packed with döner, salad and sauce.',
		category = 'food',
		weight = 400,
		stack = true,
		close = true,
	},

	['doner_patates_half'] = {
		label = 'Döner in Bread with Fries',
		description = 'Döner in flatbread with salad, sauce and fries tucked inside.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['donut_banana'] = {
		label = 'Banana Donut',
		description = 'Ring donut finished with a glossy banana glaze.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['donut_blueberry'] = {
		label = 'Blueberry Donut',
		description = 'Ring donut finished with a glossy blueberry glaze.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['donut_cherry'] = {
		label = 'Cherry Donut',
		description = 'Ring donut finished with a glossy cherry glaze.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['donut_choco'] = {
		label = 'Chocolate Donut',
		description = 'Ring donut finished with a glossy chocolate glaze.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['donut_coconut'] = {
		label = 'Coconut Donut',
		description = 'Ring donut finished with a glossy coconut glaze.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['donut_lemon'] = {
		label = 'Lemon Donut',
		description = 'Ring donut finished with a glossy lemon glaze.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['donut_mint'] = {
		label = 'Mint Donut',
		description = 'Ring donut finished with a glossy mint glaze.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['donut_orange'] = {
		label = 'Orange Donut',
		description = 'Ring donut finished with a glossy orange glaze.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['donut_raspberry'] = {
		label = 'Raspberry Donut',
		description = 'Ring donut finished with a glossy raspberry glaze.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['donut_strawberry'] = {
		label = 'Strawberry Donut',
		description = 'Ring donut finished with a glossy strawberry glaze.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['duck_ramen'] = {
		label = 'Duck Ramen',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['durum_doner'] = {
		label = 'Döner Dürüm',
		description = 'Beef döner, salad and sauce rolled tight in grilled lavash.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['durum_tavuk'] = {
		label = 'Chicken Dürüm',
		description = 'Chicken döner, salad and sauce rolled tight in grilled lavash.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['frenchfries'] = {
		label = 'French fries',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['fries'] = {
		label = 'French Fry',
		description = 'A single golden french fry.',
		category = 'food',
		weight = 15,
		stack = true,
		close = true,
		client = { image = 'fries.png' },
	},

	['fries_pack'] = {
		label = 'Portion of Fries',
		description = 'A full carton of golden fries, salted while hot.',
		category = 'food',
		weight = 250,
		stack = true,
		close = true,
	},

	['gmochi'] = {
		label = 'Green Mochi',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['hotdog'] = {
		label = 'Hotdog',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['hotdog_ketchup'] = {
		label = 'Hot Dog with Ketchup',
		description = 'Grilled sausage in a soft bun with a ketchup stripe.',
		category = 'food',
		weight = 300,
		stack = true,
		close = true,
	},

	['hotdog_ketchup_mayo'] = {
		label = 'Hot Dog with Ketchup & Mayo',
		description = 'Grilled sausage in a bun, striped with ketchup and mayo.',
		category = 'food',
		weight = 300,
		stack = true,
		close = true,
	},

	['hotdog_mayo'] = {
		label = 'Hot Dog with Mayo',
		description = 'Grilled sausage in a soft bun with a mayo stripe.',
		category = 'food',
		weight = 300,
		stack = true,
		close = true,
	},

	['icecream_banana'] = {
		label = 'Banana Ice Cream',
		description = 'A single scoop of sweet banana ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_banana_choco'] = {
		label = 'Banana & Chocolate Ice Cream',
		description = 'Two scoops in a waffle cone: sweet banana below, rich chocolate on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_banana_double'] = {
		label = 'Double Banana Ice Cream',
		description = 'Two scoops of sweet banana ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_blueberry'] = {
		label = 'Blueberry Ice Cream',
		description = 'A single scoop of tangy blueberry ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_blueberry_double'] = {
		label = 'Double Blueberry Ice Cream',
		description = 'Two scoops of tangy blueberry ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_blueberry_lemon'] = {
		label = 'Blueberry & Lemon Ice Cream',
		description = 'Two scoops in a waffle cone: tangy blueberry below, sharp lemon on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_blueberry_plain'] = {
		label = 'Blueberry & Vanilla Ice Cream',
		description = 'Two scoops in a waffle cone: tangy blueberry below, smooth vanilla on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_caramel'] = {
		label = 'Caramel Ice Cream',
		description = 'A single scoop of salted caramel ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_caramel_banana'] = {
		label = 'Caramel & Banana Ice Cream',
		description = 'Two scoops in a waffle cone: salted caramel below, sweet banana on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_caramel_coconut'] = {
		label = 'Caramel & Coconut Ice Cream',
		description = 'Two scoops in a waffle cone: salted caramel below, creamy coconut on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_caramel_double'] = {
		label = 'Double Caramel Ice Cream',
		description = 'Two scoops of salted caramel ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_cherry'] = {
		label = 'Cherry Ice Cream',
		description = 'A single scoop of dark cherry ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_cherry_choco'] = {
		label = 'Cherry & Chocolate Ice Cream',
		description = 'Two scoops in a waffle cone: dark cherry below, rich chocolate on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_cherry_double'] = {
		label = 'Double Cherry Ice Cream',
		description = 'Two scoops of dark cherry ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_cherry_strawberry'] = {
		label = 'Cherry & Strawberry Ice Cream',
		description = 'Two scoops in a waffle cone: dark cherry below, ripe strawberry on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_choco'] = {
		label = 'Chocolate Ice Cream',
		description = 'A single scoop of rich chocolate ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_choco_caramel'] = {
		label = 'Chocolate & Caramel Ice Cream',
		description = 'Two scoops in a waffle cone: rich chocolate below, salted caramel on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_choco_double'] = {
		label = 'Double Chocolate Ice Cream',
		description = 'Two scoops of rich chocolate ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_choco_mint'] = {
		label = 'Chocolate & Mint Ice Cream',
		description = 'Two scoops in a waffle cone: rich chocolate below, cool mint on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_choco_strawberry'] = {
		label = 'Chocolate & Strawberry Ice Cream',
		description = 'Two scoops in a waffle cone: rich chocolate below, ripe strawberry on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_coconut'] = {
		label = 'Coconut Ice Cream',
		description = 'A single scoop of creamy coconut ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_coconut_choco'] = {
		label = 'Coconut & Chocolate Ice Cream',
		description = 'Two scoops in a waffle cone: creamy coconut below, rich chocolate on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_coconut_double'] = {
		label = 'Double Coconut Ice Cream',
		description = 'Two scoops of creamy coconut ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_coconut_strawberry'] = {
		label = 'Coconut & Strawberry Ice Cream',
		description = 'Two scoops in a waffle cone: creamy coconut below, ripe strawberry on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_lemon'] = {
		label = 'Lemon Ice Cream',
		description = 'A single scoop of sharp lemon ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_lemon_double'] = {
		label = 'Double Lemon Ice Cream',
		description = 'Two scoops of sharp lemon ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_lemon_orange'] = {
		label = 'Lemon & Orange Ice Cream',
		description = 'Two scoops in a waffle cone: sharp lemon below, bright orange on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_mint'] = {
		label = 'Mint Ice Cream',
		description = 'A single scoop of cool mint ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_mint_double'] = {
		label = 'Double Mint Ice Cream',
		description = 'Two scoops of cool mint ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_mint_plain'] = {
		label = 'Mint & Vanilla Ice Cream',
		description = 'Two scoops in a waffle cone: cool mint below, smooth vanilla on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_orange'] = {
		label = 'Orange Ice Cream',
		description = 'A single scoop of bright orange ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_orange_double'] = {
		label = 'Double Orange Ice Cream',
		description = 'Two scoops of bright orange ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_orange_strawberry'] = {
		label = 'Orange & Strawberry Ice Cream',
		description = 'Two scoops in a waffle cone: bright orange below, ripe strawberry on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_plain'] = {
		label = 'Vanilla Ice Cream',
		description = 'A single scoop of smooth vanilla ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_plain_caramel'] = {
		label = 'Vanilla & Caramel Ice Cream',
		description = 'Two scoops in a waffle cone: smooth vanilla below, salted caramel on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_plain_choco'] = {
		label = 'Vanilla & Chocolate Ice Cream',
		description = 'Two scoops in a waffle cone: smooth vanilla below, rich chocolate on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_plain_double'] = {
		label = 'Double Vanilla Ice Cream',
		description = 'Two scoops of smooth vanilla ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_plain_strawberry'] = {
		label = 'Vanilla & Strawberry Ice Cream',
		description = 'Two scoops in a waffle cone: smooth vanilla below, ripe strawberry on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_strawberry'] = {
		label = 'Strawberry Ice Cream',
		description = 'A single scoop of ripe strawberry ice cream in a crisp waffle cone.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['icecream_strawberry_banana'] = {
		label = 'Strawberry & Banana Ice Cream',
		description = 'Two scoops in a waffle cone: ripe strawberry below, sweet banana on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_strawberry_blueberry'] = {
		label = 'Strawberry & Blueberry Ice Cream',
		description = 'Two scoops in a waffle cone: ripe strawberry below, tangy blueberry on top.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['icecream_strawberry_double'] = {
		label = 'Double Strawberry Ice Cream',
		description = 'Two scoops of ripe strawberry ice cream stacked in a waffle cone.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['kawaii_bao_matcha'] = {
		label = 'Matcha Bao Bun',
		description = 'Matcha-green steamed bun with a round open mouth, as if it just saw you coming.',
		category = 'food',
		weight = 220,
		stack = true,
		close = true,
	},

	['kawaii_bao_pink'] = {
		label = 'Peach Bao Bun',
		description = 'Peach-tinted steamed bun with a cheeky grin. Sweet filling, softer than a pillow.',
		category = 'food',
		weight = 220,
		stack = true,
		close = true,
	},

	['kawaii_bao_plain'] = {
		label = 'Smiling Bao Bun',
		description = 'Fluffy steamed bun with a pleated swirl on top and a shy little face pressed into the dough.',
		category = 'food',
		weight = 220,
		stack = true,
		close = true,
	},

	['kawaii_bao_steamer'] = {
		label = 'Bao Steamer Basket',
		description = 'Bamboo steamer holding three smiling buns. Lid already off, steam still rising.',
		category = 'food',
		weight = 700,
		stack = true,
		close = true,
	},

	['kawaii_donut_bear'] = {
		label = 'Bear Donut',
		description = 'Chocolate-glazed ring with two cocoa ears and a cream muzzle. Almost too cute to bite.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['kawaii_macaron_panda'] = {
		label = 'Panda Macaron',
		description = 'Ivory macaron shell with dark eye patches and round ears. Vanilla ganache in the middle.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['kawaii_mochi_set'] = {
		label = 'Mochi Trio Plate',
		description = 'Three rice-flour mochi on a small dish, each pulling a different face at you.',
		category = 'food',
		weight = 380,
		stack = true,
		close = true,
	},

	['kawaii_onigiri_panda'] = {
		label = 'Panda Rice Ball',
		description = 'Plump rice triangle wrapped in nori patches shaped into a panda face. Ears included.',
		category = 'food',
		weight = 260,
		stack = true,
		close = true,
	},

	['kawaii_pudding_bunny'] = {
		label = 'Bunny Pudding',
		description = 'Caramel-topped custard with two long ears standing up. Wobbles when you walk.',
		category = 'food',
		weight = 240,
		stack = true,
		close = true,
	},

	['kawaii_taiyaki_cat'] = {
		label = 'Cat Taiyaki',
		description = 'Fish-shaped batter cake with pointed ears and a whiskered grin. Warm filling inside.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['kumpir_klasik'] = {
		label = 'Classic Kumpir',
		description = 'Baked potato mashed with butter and cheese, loaded with sweetcorn, peas, pickles, olives, carrot and red cabbage.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['kumpir_rus_salatali'] = {
		label = 'Russian Salad Kumpir',
		description = 'Baked potato mashed with butter and cheese, loaded with creamy Russian salad and mixed vegetables.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['kumpir_sosisli'] = {
		label = 'Sausage Kumpir',
		description = 'Baked potato mashed with butter and cheese, loaded with sausage slices, sweetcorn and pickles.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['kumpir_sucuklu'] = {
		label = 'Sucuk Kumpir',
		description = 'Baked potato mashed with butter and cheese, loaded with slices of spiced sucuk and mixed pickles.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['kumpir_tavuklu'] = {
		label = 'Chicken Kumpir',
		description = 'Baked potato mashed with butter and cheese, loaded with shredded chicken, mayo and mixed vegetables.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['lahmacun_roll'] = {
		label = 'Lahmacun Roll',
		description = 'Thin lahmacun rolled around parsley, onion and a squeeze of lemon.',
		category = 'food',
		weight = 250,
		stack = true,
		close = true,
	},

	['lemon_cheesecake'] = {
		label = 'Lemon Cheesecake',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['lemon_donut'] = {
		label = 'Lemon Donut',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['macaroon_banana'] = {
		label = 'Banana Macaron',
		description = 'Delicate almond shells around a banana ganache.',
		category = 'food',
		weight = 30,
		stack = true,
		close = true,
	},

	['macaroon_blueberry'] = {
		label = 'Blueberry Macaron',
		description = 'Delicate almond shells around a blueberry ganache.',
		category = 'food',
		weight = 30,
		stack = true,
		close = true,
	},

	['macaroon_cherry'] = {
		label = 'Cherry Macaron',
		description = 'Delicate almond shells around a cherry ganache.',
		category = 'food',
		weight = 30,
		stack = true,
		close = true,
	},

	['macaroon_choco'] = {
		label = 'Chocolate Macaron',
		description = 'Delicate almond shells around a chocolate ganache.',
		category = 'food',
		weight = 30,
		stack = true,
		close = true,
	},

	['macaroon_coconut'] = {
		label = 'Coconut Macaron',
		description = 'Delicate almond shells around a coconut ganache.',
		category = 'food',
		weight = 30,
		stack = true,
		close = true,
	},

	['macaroon_cream'] = {
		label = 'Cream Macaron',
		description = 'Delicate almond shells around a cream ganache.',
		category = 'food',
		weight = 30,
		stack = true,
		close = true,
	},

	['macaroon_lemon'] = {
		label = 'Lemon Macaron',
		description = 'Delicate almond shells around a lemon ganache.',
		category = 'food',
		weight = 30,
		stack = true,
		close = true,
	},

	['macaroon_mint'] = {
		label = 'Mint Macaron',
		description = 'Delicate almond shells around a mint ganache.',
		category = 'food',
		weight = 30,
		stack = true,
		close = true,
	},

	['macaroon_orange'] = {
		label = 'Orange Macaron',
		description = 'Delicate almond shells around a orange ganache.',
		category = 'food',
		weight = 30,
		stack = true,
		close = true,
	},

	['macaroon_strawberry'] = {
		label = 'Strawberry Macaron',
		description = 'Delicate almond shells around a strawberry ganache.',
		category = 'food',
		weight = 30,
		stack = true,
		close = true,
	},

	['magic_altin_truf'] = {
		label = 'Golden Winged Truffle',
		description = 'Dark chocolate truffle rolled in gold dust, with a pair of gilded wings that never stop fluttering.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['magic_asa_cubugu'] = {
		label = 'Wand Stick',
		description = 'Solid chocolate cast in the shape of a wand, ridged handle and a gold band.',
		category = 'food',
		weight = 70,
		stack = true,
		close = true,
	},

	['magic_bal_petegi'] = {
		label = 'Honeycomb Toffee',
		description = 'Cracked slab of golden honeycomb toffee, airy and shatteringly brittle.',
		category = 'food',
		weight = 130,
		stack = true,
		close = true,
	},

	['magic_baykus_kurabiye'] = {
		label = 'Owl Post Biscuit',
		description = 'Tufted owl cut from shortbread with whole almond eyes, clutching a wax-sealed letter.',
		category = 'food',
		weight = 120,
		stack = true,
		close = true,
	},

	['magic_ebedi_tas'] = {
		label = 'Everlife Stone',
		description = 'Rough blood-red crystal of hardened sugar. Alchemists swear it stretches a life; bakers swear it cracks a tooth.',
		category = 'food',
		weight = 300,
		stack = true,
		close = true,
	},

	['magic_kopek_muffin'] = {
		label = 'Three-Headed Hound Muffin',
		description = 'Chocolate muffin in a plum liner, crowned with three little hounds that growl if you pick the wrong head.',
		category = 'food',
		weight = 260,
		stack = true,
		close = true,
	},

	['magic_sapka_muffin'] = {
		label = 'Whispering Hat Muffin',
		description = 'Spiced muffin wearing a droopy felt hat. The crease across the brim mutters which house you belong to before you bite.',
		category = 'food',
		weight = 250,
		stack = true,
		close = true,
	},

	['magic_yilan_muffin'] = {
		label = 'Coiled Serpent Muffin',
		description = 'The swirl on top is not frosting. It is a candied serpent, still coiled and still tasting the air.',
		category = 'food',
		weight = 240,
		stack = true,
		close = true,
	},

	['magic_yildiz_kurabiye'] = {
		label = 'Iced Star Biscuit',
		description = 'Spiced shortbread star under a thin white glaze, dusted with edible gold.',
		category = 'food',
		weight = 90,
		stack = true,
		close = true,
	},

	['margaritapizza'] = {
		label = 'Margarita Pizza',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['midye_dolma_single'] = {
		label = 'Stuffed Mussel',
		description = 'One stuffed mussel packed with spiced rice, pine nuts and currants.',
		category = 'food',
		weight = 45,
		stack = true,
		close = true,
	},

	['mint_donut'] = {
		label = 'Mint Donut',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['mint_icecream'] = {
		label = 'Mint Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['mint_macaroon'] = {
		label = 'Mint Macaroon',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['mint_muffin'] = {
		label = 'Mint muffin',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['mochi_banana'] = {
		label = 'Banana Mochi',
		description = 'Soft rice cake wrapped around banana ice cream.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['mochi_blueberry'] = {
		label = 'Blueberry Mochi',
		description = 'Soft rice cake wrapped around blueberry ice cream.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['mochi_cherry'] = {
		label = 'Cherry Mochi',
		description = 'Soft rice cake wrapped around cherry ice cream.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['mochi_choco'] = {
		label = 'Chocolate Mochi',
		description = 'Soft rice cake wrapped around chocolate ice cream.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['mochi_coconut'] = {
		label = 'Coconut Mochi',
		description = 'Soft rice cake wrapped around coconut ice cream.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['mochi_lemon'] = {
		label = 'Lemon Mochi',
		description = 'Soft rice cake wrapped around lemon ice cream.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['mochi_mint'] = {
		label = 'Mint Mochi',
		description = 'Soft rice cake wrapped around mint ice cream.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['mochi_orange'] = {
		label = 'Orange Mochi',
		description = 'Soft rice cake wrapped around orange ice cream.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['mochi_raspberry'] = {
		label = 'Raspberry Mochi',
		description = 'Soft rice cake wrapped around raspberry ice cream.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['mochi_strawberry'] = {
		label = 'Strawberry Mochi',
		description = 'Soft rice cake wrapped around strawberry ice cream.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['mushroom_soup'] = {
		label = 'Mushroom Soup',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['mushroompizza'] = {
		label = 'Mushroom Pizza',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['mussel_single'] = {
		label = 'Mussel',
		description = 'A single steamed mussel in its shell.',
		category = 'food',
		weight = 35,
		stack = true,
		close = true,
	},

	['nugget'] = {
		label = 'Raw Nugget',
		description = '',
		category = 'food',
		weight = 100,
		stack = true,
		close = true,
	},

	['nugget2'] = {
		label = 'Cooked Nugget',
		description = '',
		category = 'food',
		weight = 100,
		stack = true,
		close = true,
	},

	['omochi'] = {
		label = 'Orange Mochi',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['onion_ring'] = {
		label = 'Onion Ring',
		description = 'One crunchy battered onion ring.',
		category = 'food',
		weight = 35,
		stack = true,
		close = true,
	},

	['onion_ring_pack'] = {
		label = 'Onion Rings',
		description = 'A portion of battered onion rings, fried golden.',
		category = 'food',
		weight = 250,
		stack = true,
		close = true,
	},

	['orange_macaroon'] = {
		label = 'Orange Macaroon',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['orange_muffin'] = {
		label = 'Orange muffin',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['packetatom'] = {
		label = 'Up un Atom',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packetbahama'] = {
		label = 'Bahama Mamas',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packetbeanmachine'] = {
		label = 'Bean Machine Cafe',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packetburger'] = {
		label = 'Burger Shot',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packetdinner'] = {
		label = 'Pops Dinner',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packethornys'] = {
		label = 'Hornys',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packeticecream'] = {
		label = 'Dondurmacı',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packetkoi'] = {
		label = 'KOI',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packetlumipier'] = {
		label = 'Lumi Cafe',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packetpearls'] = {
		label = 'Pearls',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packetpizza'] = {
		label = 'Pizza This',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packettequilala'] = {
		label = 'Tequi-la-la',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packettriads'] = {
		label = 'Triads',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packetuwu'] = {
		label = 'Cat Cafe',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['packetvanillaunicorn'] = {
		label = 'Vanilla Unicorn',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['pizza_ananasli'] = {
		label = 'Hawaiian Pizza',
		description = 'Stone-baked pizza topped with ham and pineapple.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['pizza_domatesli'] = {
		label = 'Tomato Pizza',
		description = 'Stone-baked pizza topped with fresh tomato and basil.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['pizza_etli'] = {
		label = 'Beef Pizza',
		description = 'Stone-baked pizza topped with seasoned minced beef.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['pizza_karisik'] = {
		label = 'Mixed Pizza',
		description = 'Stone-baked pizza topped with sausage, peppers, mushrooms and olives.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['pizza_mantarli'] = {
		label = 'Mushroom Pizza',
		description = 'Stone-baked pizza topped with sautéed mushrooms.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['pizza_margherita'] = {
		label = 'Margherita Pizza',
		description = 'Stone-baked pizza topped with tomato, mozzarella and basil.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['pizza_sebzeli'] = {
		label = 'Vegetable Pizza',
		description = 'Stone-baked pizza topped with roasted seasonal vegetables.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['pizza_sucuklu'] = {
		label = 'Sucuk Pizza',
		description = 'Stone-baked pizza topped with spiced Turkish sucuk.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['pizza_tavuklu'] = {
		label = 'Chicken Pizza',
		description = 'Stone-baked pizza topped with grilled chicken and sweetcorn.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['pizza_tuna'] = {
		label = 'Tuna Pizza',
		description = 'Stone-baked pizza topped with tuna and red onion.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['plate_baklava'] = {
		label = 'Plate of Baklava',
		description = 'Layered filo soaked in syrup and packed with pistachio.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_borek_kiymali'] = {
		label = 'Plate of Minced Beef Börek',
		description = 'A full plate of flaky börek stuffed with minced beef.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['plate_borek_patatesli'] = {
		label = 'Plate of Potato Börek',
		description = 'A full plate of flaky börek stuffed with potato.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['plate_borek_peynirli'] = {
		label = 'Plate of Feta Cheese Börek',
		description = 'A full plate of flaky börek stuffed with feta cheese.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['plate_cake_chocolate'] = {
		label = 'Chocolate Cake Slice',
		description = 'A slice of moist chocolate cake with dark ganache.',
		category = 'food',
		weight = 250,
		stack = true,
		close = true,
	},

	['plate_cake_cream'] = {
		label = 'Cream Cake Slice',
		description = 'Sponge layered with vanilla cream and fresh berries.',
		category = 'food',
		weight = 250,
		stack = true,
		close = true,
	},

	['plate_cake_lemon'] = {
		label = 'Lemon Cake Slice',
		description = 'Zesty lemon sponge under a sharp citrus glaze.',
		category = 'food',
		weight = 250,
		stack = true,
		close = true,
	},

	['plate_cake_strawberry'] = {
		label = 'Strawberry Cake Slice',
		description = 'Cream sponge crowned with fresh strawberries.',
		category = 'food',
		weight = 250,
		stack = true,
		close = true,
	},

	['plate_calamari'] = {
		label = 'Calamari',
		description = 'Crisp fried squid rings served with lemon.',
		category = 'food',
		weight = 400,
		stack = true,
		close = true,
	},

	['plate_chicken_legs'] = {
		label = 'Roast Chicken Legs',
		description = 'Oven-roasted chicken legs with crisp seasoned skin.',
		category = 'food',
		weight = 550,
		stack = true,
		close = true,
	},

	['plate_chicken_rice'] = {
		label = 'Chicken with Rice',
		description = 'Grilled chicken over buttered pilaf rice.',
		category = 'food',
		weight = 550,
		stack = true,
		close = true,
	},

	['plate_cig_kofte'] = {
		label = 'Plate of Çiğ Köfte',
		description = 'Spiced bulgur köfte with lettuce, lemon and pomegranate sauce.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_crab'] = {
		label = 'Crab',
		description = 'Whole cooked crab, cracked and ready to pick.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['plate_fish'] = {
		label = 'Grilled Fish',
		description = 'Whole grilled fish with lemon and rocket.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['plate_hamsi'] = {
		label = 'Plate of Anchovies',
		description = 'Flour-dusted Black Sea anchovies fried crisp, with lemon.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['plate_iskender'] = {
		label = 'İskender Kebab',
		description = 'Döner over bread cubes with tomato sauce, butter and yoghurt.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['plate_karniyarik'] = {
		label = 'Karnıyarık',
		description = 'Aubergine split and stuffed with minced beef and peppers.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['plate_kofte_rice'] = {
		label = 'Köfte with Rice',
		description = 'Grilled köfte served with buttered pilaf.',
		category = 'food',
		weight = 550,
		stack = true,
		close = true,
	},

	['plate_lahmacun'] = {
		label = 'Plate of Lahmacun',
		description = 'Thin dough baked with spiced minced meat topping.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_manti'] = {
		label = 'Mantı',
		description = 'Tiny dumplings under garlic yoghurt and chilli butter.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['plate_midye_dolma'] = {
		label = 'Plate of Stuffed Mussels',
		description = 'Mussel shells packed with spiced rice, served with lemon.',
		category = 'food',
		weight = 400,
		stack = true,
		close = true,
	},

	['plate_mussels'] = {
		label = 'Mussels',
		description = 'Steamed mussels served in the shell.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['plate_octopus'] = {
		label = 'Grilled Octopus',
		description = 'Charred octopus with olive oil and lemon.',
		category = 'food',
		weight = 450,
		stack = true,
		close = true,
	},

	['plate_omelette'] = {
		label = 'Omelette',
		description = 'Fluffy folded omelette, straight from the pan.',
		category = 'food',
		weight = 300,
		stack = true,
		close = true,
	},

	['plate_oysters'] = {
		label = 'Oysters',
		description = 'Raw oysters on ice with lemon wedges.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_pasta_alfredo'] = {
		label = 'Pasta Alfredo',
		description = 'Fettuccine in a rich butter and parmesan cream.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['plate_pasta_arrabbiata'] = {
		label = 'Pasta Arrabbiata',
		description = 'Pasta in a fiery tomato and chilli sauce.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['plate_pasta_bolognese'] = {
		label = 'Pasta Bolognese',
		description = 'Pasta under a slow-cooked minced beef ragù.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['plate_pasta_carbonara'] = {
		label = 'Pasta Carbonara',
		description = 'Pasta bound in egg, pecorino and crisp guanciale.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['plate_pasta_pesto'] = {
		label = 'Pasta Pesto',
		description = 'Pasta tossed in basil, pine nut and parmesan pesto.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['plate_pilav_nohut'] = {
		label = 'Chickpea Pilaf',
		description = 'Buttered rice pilaf with tender chickpeas.',
		category = 'food',
		weight = 500,
		stack = true,
		close = true,
	},

	['plate_salad'] = {
		label = 'Salad',
		description = 'Crisp mixed leaves with tomato, cucumber and olive oil.',
		category = 'food',
		weight = 300,
		stack = true,
		close = true,
	},

	['plate_sarma'] = {
		label = 'Plate of Stuffed Vine Leaves',
		description = 'Vine leaves rolled around spiced rice, served cold.',
		category = 'food',
		weight = 400,
		stack = true,
		close = true,
	},

	['plate_shrimp'] = {
		label = 'Shrimp',
		description = 'Sautéed shrimp in garlic butter.',
		category = 'food',
		weight = 400,
		stack = true,
		close = true,
	},

	['plate_steak'] = {
		label = 'Steak',
		description = 'Thick grilled steak, rested and sliced.',
		category = 'food',
		weight = 600,
		stack = true,
		close = true,
	},

	['plate_sushi_california'] = {
		label = 'California Roll Plate',
		description = 'Crab, avocado and cucumber rolls with sesame.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_sushi_maki_avocado'] = {
		label = 'Avocado Maki Plate',
		description = 'Slim seaweed rolls filled with ripe avocado.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_sushi_maki_cucumber'] = {
		label = 'Cucumber Maki Plate',
		description = 'Slim seaweed rolls filled with crisp cucumber.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_sushi_maki_salmon'] = {
		label = 'Salmon Maki Plate',
		description = 'Slim seaweed rolls filled with fresh salmon.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_sushi_nigiri_salmon'] = {
		label = 'Salmon Nigiri Plate',
		description = 'Hand-pressed rice topped with salmon slices.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_sushi_nigiri_shrimp'] = {
		label = 'Shrimp Nigiri Plate',
		description = 'Hand-pressed rice topped with sweet shrimp.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_sushi_nigiri_tuna'] = {
		label = 'Tuna Nigiri Plate',
		description = 'Hand-pressed rice topped with lean tuna.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['plate_toast'] = {
		label = 'Toasted Sandwich',
		description = 'Pressed toast with melted cheese and sucuk.',
		category = 'food',
		weight = 300,
		stack = true,
		close = true,
	},

	['pmochi'] = {
		label = 'Pink Mochi',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['protein'] = {
		label = 'Protein',
		description = 'Odzywka bialkowa wspomagajaca budowe masy miesniowej.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
		client = { image = 'protein.png' },
	},

	['pumpkin_soup'] = {
		label = 'Pumpkin Soup',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['quesadilla'] = {
		label = 'Quesadilla',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['ramen'] = {
		label = 'Ramen',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['raspberry_brownies'] = {
		label = 'Raspberry Brownie',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['salad'] = {
		label = 'Salad',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['salmon_cream_bagel'] = {
		label = 'Salamlı Simit',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['sandwich'] = {
		label = 'Sandwich',
		description = 'Nice bread for your stomach',
		category = 'food',
		weight = 200,
		stack = false,
		close = true,
		client = { image = 'sandwich.png' },
	},

	['sandwich_chicken'] = {
		label = 'Chicken Sandwich',
		description = 'A white baguette filled with grilled chicken, lettuce and tomato.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['sandwich_chicken_half'] = {
		label = 'Chicken Sandwich (Half)',
		description = 'Half a white baguette filled with grilled chicken, lettuce and tomato.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['sandwich_pastrami'] = {
		label = 'Pastrami Sandwich',
		description = 'A white baguette filled with sliced pastrami, pickles and mustard.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['sandwich_pastrami_half'] = {
		label = 'Pastrami Sandwich (Half)',
		description = 'Half a white baguette filled with sliced pastrami, pickles and mustard.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['sandwich_veggie'] = {
		label = 'Veggie Sandwich',
		description = 'A white baguette filled with grilled vegetables and fresh greens.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['sandwich_veggie_half'] = {
		label = 'Veggie Sandwich (Half)',
		description = 'Half a white baguette filled with grilled vegetables and fresh greens.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['sandwich_wheat_chicken'] = {
		label = 'Wholewheat Chicken Sandwich',
		description = 'A wholewheat baguette filled with grilled chicken, lettuce and tomato.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['sandwich_wheat_chicken_half'] = {
		label = 'Wholewheat Chicken Sandwich (Half)',
		description = 'Half a wholewheat baguette filled with grilled chicken, lettuce and tomato.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['sandwich_wheat_pastrami'] = {
		label = 'Wholewheat Pastrami Sandwich',
		description = 'A wholewheat baguette filled with sliced pastrami, pickles and mustard.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['sandwich_wheat_pastrami_half'] = {
		label = 'Wholewheat Pastrami Sandwich (Half)',
		description = 'Half a wholewheat baguette filled with sliced pastrami, pickles and mustard.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['sandwich_wheat_veggie'] = {
		label = 'Wholewheat Veggie Sandwich',
		description = 'A wholewheat baguette filled with grilled vegetables and fresh greens.',
		category = 'food',
		weight = 350,
		stack = true,
		close = true,
	},

	['sandwich_wheat_veggie_half'] = {
		label = 'Wholewheat Veggie Sandwich (Half)',
		description = 'Half a wholewheat baguette filled with grilled vegetables and fresh greens.',
		category = 'food',
		weight = 180,
		stack = true,
		close = true,
	},

	['sarma_single'] = {
		label = 'Stuffed Vine Leaf',
		description = 'A single vine leaf rolled around spiced rice and herbs.',
		category = 'food',
		weight = 40,
		stack = true,
		close = true,
	},

	['sausagepizza'] = {
		label = 'Sausage Pizza',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['serratedfrenchfries'] = {
		label = 'Serrated French fries',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['shrimp_ramen'] = {
		label = 'Shrimp Ramen',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['snikkel_candy'] = {
		label = 'Snikkel',
		description = 'Some delicious candy :O',
		category = 'food',
		weight = 100,
		stack = true,
		close = true,
		client = { image = 'snikkel_candy.png' },
	},

	['spagetti'] = {
		label = 'Spagetti',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['strawberry_brownies'] = {
		label = 'Strawberry Brownie',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['strawberry_cake'] = {
		label = 'Strawberry Cake',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['strawberry_cheesecake'] = {
		label = 'Strawberry Cheesecake',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['strawberry_donut'] = {
		label = 'Strawberry Donut',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['strawberry_icecream'] = {
		label = 'Strawberry Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['strawberry_macaroon'] = {
		label = 'Strawberry Macaroon',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['strawberry_mint_icecream'] = {
		label = 'Strawberry&Mint Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['strawberry_muffin'] = {
		label = 'Strawberry muffin',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['strawberry_vanilla_icecream'] = {
		label = 'Strawberry&Vanilla Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['sushi_california_chopstick'] = {
		label = 'California Roll on Chopsticks',
		description = 'One california roll held between wooden chopsticks.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['sushi_maki_avocado_chopstick'] = {
		label = 'Avocado Maki on Chopsticks',
		description = 'One avocado maki roll held between wooden chopsticks.',
		category = 'food',
		weight = 55,
		stack = true,
		close = true,
	},

	['sushi_maki_cucumber_chopstick'] = {
		label = 'Cucumber Maki on Chopsticks',
		description = 'One cucumber maki roll held between wooden chopsticks.',
		category = 'food',
		weight = 55,
		stack = true,
		close = true,
	},

	['sushi_maki_salmon_chopstick'] = {
		label = 'Salmon Maki on Chopsticks',
		description = 'One salmon maki roll held between wooden chopsticks.',
		category = 'food',
		weight = 60,
		stack = true,
		close = true,
	},

	['sushi_nigiri_salmon_chopstick'] = {
		label = 'Salmon Nigiri on Chopsticks',
		description = 'A slice of salmon over pressed rice, held between wooden chopsticks.',
		category = 'food',
		weight = 65,
		stack = true,
		close = true,
	},

	['sushi_nigiri_shrimp_chopstick'] = {
		label = 'Shrimp Nigiri on Chopsticks',
		description = 'A butterflied shrimp over pressed rice, held between wooden chopsticks.',
		category = 'food',
		weight = 65,
		stack = true,
		close = true,
	},

	['sushi_nigiri_tuna_chopstick'] = {
		label = 'Tuna Nigiri on Chopsticks',
		description = 'A slice of tuna over pressed rice, held between wooden chopsticks.',
		category = 'food',
		weight = 65,
		stack = true,
		close = true,
	},

	['taco_al_pastor'] = {
		label = 'Al Pastor Taco',
		description = 'Soft corn tortilla filled with marinated pork and pineapple, onion and coriander.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['taco_asada'] = {
		label = 'Carne Asada Taco',
		description = 'Soft corn tortilla filled with grilled skirt steak, onion and coriander.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['taco_bean'] = {
		label = 'Bean Taco',
		description = 'Soft corn tortilla filled with refried beans and cheese, onion and coriander.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['taco_beef'] = {
		label = 'Beef Taco',
		description = 'Soft corn tortilla filled with seasoned ground beef, onion and coriander.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['taco_birria'] = {
		label = 'Birria Taco',
		description = 'Soft corn tortilla filled with slow-stewed beef and consommé, onion and coriander.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['taco_chicken'] = {
		label = 'Chicken Taco',
		description = 'Soft corn tortilla filled with grilled chicken, onion and coriander.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['taco_chorizo'] = {
		label = 'Chorizo Taco',
		description = 'Soft corn tortilla filled with spiced chorizo, onion and coriander.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['taco_fish'] = {
		label = 'Fish Taco',
		description = 'Soft corn tortilla filled with battered white fish and slaw, onion and coriander.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['taco_shrimp'] = {
		label = 'Shrimp Taco',
		description = 'Soft corn tortilla filled with garlic shrimp, onion and coriander.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['taco_veggie'] = {
		label = 'Veggie Taco',
		description = 'Soft corn tortilla filled with grilled peppers and beans, onion and coriander.',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
	},

	['testburger'] = {
		label = 'Test Burger',
		description = '',
		category = 'food',
		tier = 'fastfood',
		weight = 220,
		stack = true,
		close = true,
		consume = 1,
		client = {
			status = { hunger = 200000, thirst = 10000 },
			anim = {
				clip = 'idle_a',
				dict = 'missheistdockssetup1clipboard@idle_a',
				flag = 49,
			},
			prop = {
				model = 'prop_rolled_sock_02',
				pos = vec3(-0.14, -0.14, -0.08),
				rot = vec3(-50.0, -50.0, 0.0),
			},
			usetime = 2500,
		},
	},

	['tiramisu'] = {
		label = 'Tiramisu',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['tomato_soup'] = {
		label = 'Tomato Soupsı',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['tonsushi'] = {
		label = 'Tuna Sushi',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['tosti'] = {
		label = 'Grilled Cheese Sandwich',
		description = 'Nice to eat',
		category = 'food',
		weight = 200,
		stack = true,
		close = true,
		degrade = 2880.0,
		decay = false,
		client = { image = 'tosti.png' },
	},

	['tunapizza'] = {
		label = 'Tuna Pizza',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['twerks_candy'] = {
		label = 'Twerks',
		description = 'Some delicious candy :O',
		category = 'food',
		weight = 100,
		stack = true,
		close = true,
		client = { image = 'twerks_candy.png' },
	},

	['uwupizza'] = {
		label = 'Uwu Pizza',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['vanilla_berry_icecream'] = {
		label = 'Berry&Vanilla Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['vanilla_cake'] = {
		label = 'Vanilla Cake',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['vanilla_icecream'] = {
		label = 'Vanilla Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['vanilla_mint_icecream'] = {
		label = 'Mint&Vanilla Ice cream',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = true,
	},

	['vegetable_ramen'] = {
		label = 'Vegetable Ramen',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['vegetable_soup'] = {
		label = 'Vegetable Soup',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	['whitechocolate_brownies'] = {
		label = 'White Chocolate Brownie',
		description = '',
		category = 'food',
		weight = 100,
		stack = false,
		close = false,
	},

	-- Drinks (173)
	['alchol'] = {
		label = 'Alcohol',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = true,
		close = true,
	},

	['alcohol'] = {
		label = 'Alcohol',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = true,
		close = true,
	},

	['ale'] = {
		label = 'Ale',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['ayran'] = {
		label = 'Ayran',
		description = 'Chilled salted yoghurt drink, the classic partner to Turkish grills.',
		category = 'drinks',
		weight = 200,
		stack = true,
		close = true,
	},

	['banana_smoothie'] = {
		label = 'Banana Smoothie',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['beer'] = {
		label = 'Beer',
		description = 'Nothing like a good cold beer!',
		category = 'drinks',
		weight = 500,
		stack = true,
		close = true,
		client = { image = 'beer.png' },
	},

	['bellini'] = {
		label = 'Bellini',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['berry_smoothie'] = {
		label = 'Raspberry Smoothie',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['blonde'] = {
		label = 'Blonde',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['bloody_mary'] = {
		label = 'Bloody Mary',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['blue_lagoon'] = {
		label = 'Blue Lagoon',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['boba'] = {
		label = 'Boba',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = true,
		close = true,
	},

	['boba_blueberry'] = {
		label = 'Blueberry Bubble Tea',
		description = 'Iced blueberry milk tea loaded with chewy tapioca pearls.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['boba_brown_sugar'] = {
		label = 'Brown Sugar Bubble Tea',
		description = 'Iced brown sugar milk tea loaded with chewy tapioca pearls.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['boba_chocolate'] = {
		label = 'Chocolate Bubble Tea',
		description = 'Iced chocolate milk tea loaded with chewy tapioca pearls.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['boba_classic'] = {
		label = 'Classic Bubble Tea',
		description = 'Iced classic milk tea loaded with chewy tapioca pearls.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['boba_mango'] = {
		label = 'Mango Bubble Tea',
		description = 'Iced mango milk tea loaded with chewy tapioca pearls.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['boba_matcha'] = {
		label = 'Matcha Bubble Tea',
		description = 'Iced matcha milk tea loaded with chewy tapioca pearls.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['boba_strawberry'] = {
		label = 'Strawberry Bubble Tea',
		description = 'Iced strawberry milk tea loaded with chewy tapioca pearls.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['boba_taro'] = {
		label = 'Taro Bubble Tea',
		description = 'Iced taro milk tea loaded with chewy tapioca pearls.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['bordeaux'] = {
		label = 'Bordeaux',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['bubbletea_caramel'] = {
		label = 'Caramel Bubble Tea',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['bubbletea_cola'] = {
		label = 'Cola Bubble Tea',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['bubbletea_green'] = {
		label = 'Green Bubble Tea',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['bubbletea_milk'] = {
		label = 'Milky Bubble Tea',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['bubbletea_strawberry'] = {
		label = 'Strawberry Bubble Tea',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['burgundy'] = {
		label = 'Burgundy',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['cabernet'] = {
		label = 'Cabernet',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['caiprinha'] = {
		label = 'Caiprinha',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['cappuccino'] = {
		label = 'cappuccino',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['carrot_juice'] = {
		label = 'Carrot Juice',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['champ'] = {
		label = 'Champ',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['chardonnay'] = {
		label = 'Chardonnay',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['coffee'] = {
		label = 'coffee',
		description = '',
		category = 'drinks',
		weight = 0,
		stack = false,
		close = true,
		client = { image = 'coffee.png' },
	},

	['coffee_1x'] = {
		label = 'small coffee',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['coffee_2x'] = {
		label = 'medium coffee',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['coffee_3x'] = {
		label = 'large coffee',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['coffee_americano'] = {
		label = 'Americano',
		description = 'Espresso stretched with hot water for a long, clean cup.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['coffee_cappuccino'] = {
		label = 'Cappuccino',
		description = 'Espresso under a thick cap of steamed milk foam.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['coffee_caramel_latte'] = {
		label = 'Caramel Latte',
		description = 'Milky latte sweetened with a generous swirl of caramel.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['coffee_espresso'] = {
		label = 'Espresso',
		description = 'A short, dense shot with a heavy crema. Pure wake-up.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['coffee_flat_white'] = {
		label = 'Flat White',
		description = 'Double ristretto with silky microfoam and no bubbles.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['coffee_iced_latte'] = {
		label = 'Iced Latte',
		description = 'Chilled espresso and cold milk poured over ice.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['coffee_latte_macchiato'] = {
		label = 'Latte Macchiato',
		description = 'Layered warm milk marked with a slow shot of espresso.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['coffee_matcha_latte'] = {
		label = 'Matcha Latte',
		description = 'Stone-ground green tea whisked into steamed milk.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['coffee_mocha'] = {
		label = 'Mocha',
		description = 'Espresso and chocolate under whipped milk foam.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['cosmopolitan'] = {
		label = 'Cosmopolitan',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['cranberry_juice'] = {
		label = 'Cranberry Juice',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['cuba_libre'] = {
		label = 'Cuba Libre',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['ecola'] = {
		label = 'Cola',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['ecolalight'] = {
		label = 'Cola Light',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['espresso'] = {
		label = 'Espresso',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = true,
		close = false,
	},

	['espresso_martini'] = {
		label = 'Espresso Martini',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['gin_gimlit'] = {
		label = 'Gin Gimlit',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['gin_tonic'] = {
		label = 'Gin & Tonic',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['grapejuice'] = {
		label = 'Grape Juice',
		description = 'Grape juice is said to be healthy',
		category = 'drinks',
		weight = 200,
		stack = true,
		close = false,
		client = { image = 'grapejuice.png' },
	},

	['grey_hound'] = {
		label = 'Grey Hound',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['harvey_wallbanger'] = {
		label = 'Harvey Wallbanger',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['irish_coffee'] = {
		label = 'Irish Coffee',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['juice_ananas'] = {
		label = 'Pineapple Juice',
		description = 'Pressed pineapple, tart and tropical.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['juice_armut'] = {
		label = 'Pear Juice',
		description = 'Soft pressed pear juice, mellow and sweet.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['juice_bogurtlen'] = {
		label = 'Blackberry Juice',
		description = 'Deep blackberry juice with a wild, tangy edge.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['juice_cilek'] = {
		label = 'Strawberry Juice',
		description = 'Thick strawberry juice, sweet and fragrant.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['juice_elma'] = {
		label = 'Apple Juice',
		description = 'Clear apple juice, crisp and refreshing.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['juice_kiraz'] = {
		label = 'Cherry Juice',
		description = 'Dark cherry juice with a rich, rounded sweetness.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['juice_limonata'] = {
		label = 'Lemonade Juice',
		description = 'Freshly squeezed lemonade; cuts thirst instantly.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['juice_multivitamin'] = {
		label = 'Multivitamin Juice',
		description = 'A blend of mixed fruits packed with vitamins.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['juice_muz'] = {
		label = 'Banana Juice',
		description = 'Creamy banana juice, thick and filling.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['juice_portakal'] = {
		label = 'Orange Juice',
		description = 'Freshly squeezed orange juice, pulp and all.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['juice_seftali'] = {
		label = 'Peach Juice',
		description = 'Velvety peach nectar, sweet and heavy.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['kawaii_boba_matcha'] = {
		label = 'Matcha Cat Bubble Tea',
		description = 'Matcha milk tea with tapioca pearls and a pointy-eared cat printed on the cup.',
		category = 'drinks',
		weight = 380,
		stack = true,
		close = true,
	},

	['kawaii_boba_taro'] = {
		label = 'Taro Bear Bubble Tea',
		description = 'Lilac taro milk tea, pearls floating right under the lid, bear face on the cup.',
		category = 'drinks',
		weight = 380,
		stack = true,
		close = true,
	},

	['kawaii_hotchoco_bear'] = {
		label = 'Bear Hot Chocolate',
		description = 'Mug of hot chocolate crowned with marshmallows, a bear face on the front and the handle on the right.',
		category = 'drinks',
		weight = 320,
		stack = true,
		close = true,
	},

	['kawaii_smoothie_bear'] = {
		label = 'Bear Strawberry Smoothie',
		description = 'Strawberry smoothie in a to-go cup with a bear face and round ears stuck on the front.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['kawaii_smoothie_bunny'] = {
		label = 'Bunny Vanilla Smoothie',
		description = 'Vanilla smoothie topped with a domed lid, long bunny ears leaning over the cup.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['kawaii_smoothie_cat'] = {
		label = 'Cat Mango Smoothie',
		description = 'Golden mango smoothie with a pointy-eared cat watching you from the cup.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['kawaii_smoothie_fox'] = {
		label = 'Fox Peach Smoothie',
		description = 'Peach smoothie in a burnt-orange cup with a sly little fox on the side.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['kawaii_smoothie_panda'] = {
		label = 'Panda Chocolate Smoothie',
		description = 'Thick chocolate smoothie guarded by a panda with two black ears.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['kawaii_soda_frog'] = {
		label = 'Frog Melon Soda',
		description = 'Bright green melon soda with a wide-eyed frog staring out of the cup.',
		category = 'drinks',
		weight = 330,
		stack = true,
		close = true,
	},

	['kiwi_smoothie'] = {
		label = 'Kiwi Smoothie',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['kurkakola'] = {
		label = 'Cola',
		description = '',
		category = 'drinks',
		tier = 'junkdrink',
		weight = 100,
		stack = true,
		close = true,
		consume = 1,
		degrade = 0.5,
		decay = false,
		client = {
			status = { thirst = 10000 },
			anim = { clip = 'loop_bottle', dict = 'mp_player_intdrink', flag = 49 },
			prop = {
				bone = 60309,
				model = 'vw_prop_casino_water_bottle_01a',
				pos = vec3(0.0, 0.0, -0.05000000074505),
				rot = vec3(0.0, 0.0, -40.0),
			},
			usetime = 2500,
		},
	},

	['larger'] = {
		label = 'Larger',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['latte'] = {
		label = 'Latte',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['latte_macchiato'] = {
		label = 'Latte Macchiato',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['lemonade_juice'] = {
		label = 'Lemonade Juice',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['magic_altin_iksir'] = {
		label = 'Golden Luck Elixir',
		description = 'A thimble of shimmering gold liquid. One sip is said to be plenty.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['magic_ay_sutu'] = {
		label = 'Moonlight Milk',
		description = 'Corked bottle of milk steeped under a full moon. Pale, sweet and soothing.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['magic_baharatli_sarap'] = {
		label = 'Mulled Wine',
		description = 'Bronze cup of hot spiced wine with a slice of orange and two cloves still floating on top.',
		category = 'drinks',
		weight = 360,
		stack = true,
		close = true,
	},

	['magic_balkabagi_suyu'] = {
		label = 'Pumpkin Juice Cup',
		description = 'Ribbed pumpkin cup with a curled vine handle, brimming with cold spiced juice.',
		category = 'drinks',
		weight = 400,
		stack = true,
		close = true,
	},

	['magic_burgu_iksir'] = {
		label = 'Twisting Goblet',
		description = 'Spiral-blown goblet of teal draught. The glass keeps turning even when you hold it still.',
		category = 'drinks',
		weight = 380,
		stack = true,
		close = true,
	},

	['magic_ejderha_atesi'] = {
		label = 'Dragonfire',
		description = 'Cut-crystal tumbler of burning orange spirit. Heat first, regret later.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['magic_fener_kupa'] = {
		label = 'Lantern Cup',
		description = 'Six-sided lantern cup framed in blackened iron. The amber drink inside throws light on whatever you are reading.',
		category = 'drinks',
		weight = 450,
		stack = true,
		close = true,
	},

	['magic_gozyasi_sise'] = {
		label = 'Teardrop Goblet',
		description = 'Teardrop bowl on a pewter foot with a silver lip band. One long draught, meant to be shared.',
		category = 'drinks',
		weight = 360,
		stack = true,
		close = true,
	},

	['magic_iksir_kirmizi'] = {
		label = 'Crimson Potion',
		description = 'Round corked flask of deep red draught, sealed with dark wax.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['magic_iksir_mavi'] = {
		label = 'Azure Potion',
		description = 'Tall slim bottle of clear blue liquid. Cold going down, calm afterwards.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['magic_iksir_mor'] = {
		label = 'Violet Potion',
		description = 'Faceted conical flask of purple brew that never quite settles.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['magic_iksir_yesil'] = {
		label = 'Verdant Potion',
		description = 'Squat green bottle, cork jammed tight and stamped with a wax seal.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['magic_imbik_surubu'] = {
		label = 'Alembic Cup',
		description = 'Round-bellied alembic cup with a swan-neck spout for a handle, still warm from the bench.',
		category = 'drinks',
		weight = 450,
		stack = true,
		close = true,
	},

	['magic_kanatli_kadeh'] = {
		label = 'Winged Chalice',
		description = 'Night-blue enamel chalice flecked with stars, gilt rim and a pair of small gold wings. The draught glows faintly.',
		category = 'drinks',
		weight = 430,
		stack = true,
		close = true,
	},

	['magic_kazan_kupa'] = {
		label = 'Cauldron Latte',
		description = 'Heavy speckled stoneware mug of spiced cauldron latte, buried under a tall swirl of cream and caramel.',
		category = 'drinks',
		weight = 420,
		stack = true,
		close = true,
	},

	['magic_kucuk_kazan'] = {
		label = 'Bubbling Cauldron Brew',
		description = 'A three-legged iron cauldron the size of a mug, still bubbling. Do not ask what is in it.',
		category = 'drinks',
		weight = 460,
		stack = true,
		close = true,
	},

	['magic_kum_saati'] = {
		label = 'Hourglass Goblet',
		description = 'Hourglass-shaped goblet banded in oak. Drink it down and the level creeps back up.',
		category = 'drinks',
		weight = 430,
		stack = true,
		close = true,
	},

	['magic_kurbaga_cikolata'] = {
		label = 'Chocolate Frog',
		description = 'Plump dark chocolate frog with a glossy back. Sadly it does not hop.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['magic_kure_kadeh'] = {
		label = 'Orb Chalice',
		description = 'Open glass orb caged in three gold bands. The drink inside never stops swirling.',
		category = 'drinks',
		weight = 430,
		stack = true,
		close = true,
	},

	['magic_tereyagli_bira'] = {
		label = 'Butterscotch Ale',
		description = 'Dimpled pewter tankard of warm butterscotch ale under a thick collar of foam.',
		category = 'drinks',
		weight = 420,
		stack = true,
		close = true,
	},

	['magic_yildiz_sarap'] = {
		label = 'Starfall Wine',
		description = 'Gold-rimmed enamel goblet of near-black wine. Tilt it and points of light drift across the surface like a night sky.',
		category = 'drinks',
		weight = 380,
		stack = true,
		close = true,
	},

	['mai_tai'] = {
		label = 'Mai Tai',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['manhattan_martini'] = {
		label = 'Manhattan Martini',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['midori_sour'] = {
		label = 'Midori Sour',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['milk'] = {
		label = 'Milk',
		description = '',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['milkshake_cikolata'] = {
		label = 'Chocolate Milkshake',
		description = 'Thick cocoa shake crowned with a swirl of whipped cream.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['milkshake_cilek'] = {
		label = 'Strawberry Milkshake',
		description = 'Thick strawberry shake crowned with a swirl of whipped cream.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['milkshake_karamel'] = {
		label = 'Caramel Milkshake',
		description = 'Thick caramel shake crowned with a swirl of whipped cream.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['milkshake_muz'] = {
		label = 'Banana Milkshake',
		description = 'Thick banana shake crowned with a swirl of whipped cream.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['milkshake_vanilya'] = {
		label = 'Vanilla Milkshake',
		description = 'Thick vanilla shake crowned with a swirl of whipped cream.',
		category = 'drinks',
		weight = 350,
		stack = true,
		close = true,
	},

	['mimosa'] = {
		label = 'Mimosa',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['mint_julep'] = {
		label = 'Mint JuleP',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['mocha'] = {
		label = 'Mocha',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['mojito'] = {
		label = 'Mojito',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['moscow_mule'] = {
		label = 'Moscow Mule',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['nekolatte'] = {
		label = 'Neko Latte',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['old_fashioned'] = {
		label = 'Old Fashioned',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['orange_juice'] = {
		label = 'Orange Juice',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['orange_smoothie'] = {
		label = 'Orange Smoothie',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['pilsner'] = {
		label = 'Pilsner',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['pina_colada'] = {
		label = 'Pina Colada',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['pineapple_juice'] = {
		label = 'Pineapple Juice',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['pinot_nior'] = {
		label = 'Pinot Nior',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['raki'] = {
		label = 'Raki',
		description = 'Anise spirit that clouds white with water. Sip it slowly.',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = true,
	},

	['ryes'] = {
		label = 'Ryes',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['sex_on_the_beach'] = {
		label = 'Sex On The Beach',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['smoothie_ananas'] = {
		label = 'Pineapple Smoothie',
		description = 'Cold-blended fresh pineapple, thick enough to stand a straw in.',
		category = 'drinks',
		weight = 320,
		stack = true,
		close = true,
	},

	['smoothie_cilek_muz'] = {
		label = 'Strawberry Banana Smoothie',
		description = 'Cold-blended strawberry and banana, thick enough to stand a straw in.',
		category = 'drinks',
		weight = 320,
		stack = true,
		close = true,
	},

	['smoothie_mango'] = {
		label = 'Mango Smoothie',
		description = 'Cold-blended ripe mango, thick enough to stand a straw in.',
		category = 'drinks',
		weight = 320,
		stack = true,
		close = true,
	},

	['smoothie_orman_meyveli'] = {
		label = 'Mixed Berry Smoothie',
		description = 'Cold-blended blackberries, raspberries and blueberries, thick enough to stand a straw in.',
		category = 'drinks',
		weight = 320,
		stack = true,
		close = true,
	},

	['smoothie_seftali'] = {
		label = 'Peach Smoothie',
		description = 'Cold-blended sun-ripened peach, thick enough to stand a straw in.',
		category = 'drinks',
		weight = 320,
		stack = true,
		close = true,
	},

	['soda'] = {
		label = 'Soda',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = true,
		close = true,
	},

	['soda_cilek'] = {
		label = 'Strawberry Sparkling Water',
		description = 'Sparkling mineral water with ripe strawberry.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['soda_elma'] = {
		label = 'Apple Sparkling Water',
		description = 'Sparkling mineral water flavoured with crisp apple.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['soda_karpuz'] = {
		label = 'Watermelon Sparkling Water',
		description = 'Sparkling mineral water with sweet watermelon.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['soda_limon'] = {
		label = 'Lemon Sparkling Water',
		description = 'Sparkling mineral water with a bright lemon twist.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['soda_mandalina'] = {
		label = 'Tangerine Sparkling Water',
		description = 'Sparkling mineral water with fragrant tangerine.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['soda_nane_limon'] = {
		label = 'Mint & Lemon Sparkling Water',
		description = 'Sparkling mineral water with mint and lemon.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['soda_portakal'] = {
		label = 'Orange Sparkling Water',
		description = 'Sparkling mineral water with juicy orange.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['soda_sade'] = {
		label = 'Plain Sparkling Water',
		description = 'Plain sparkling mineral water, sharp and clean.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['soda_seftali'] = {
		label = 'Peach Sparkling Water',
		description = 'Sparkling mineral water with soft peach aroma.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['soda_visne'] = {
		label = 'Sour Cherry Sparkling Water',
		description = 'Sparkling mineral water with tart sour cherry.',
		category = 'drinks',
		weight = 250,
		stack = true,
		close = true,
	},

	['sprunk'] = {
		label = 'Sprite',
		description = '',
		category = 'drinks',
		tier = 'junkdrink',
		weight = 100,
		stack = false,
		close = true,
		consume = 1,
		client = {
			image = 'sprunk.png',
			status = { thirst = 200000 },
			anim = { clip = 'loop_bottle', dict = 'mp_player_intdrink' },
			prop = {
				model = 3141696105,
				pos = vec3(0.01, 0.01, 0.06),
				rot = vec3(5.0, 5.0, -180.5),
			},
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk',
		},
	},

	['sprunklight'] = {
		label = 'Sprite Light',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = true,
	},

	['stout'] = {
		label = 'stout',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['strawberry_smoothie'] = {
		label = 'Strawberry Smoothie',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['tea_adacayi'] = {
		label = 'Sage Tea',
		description = 'Soothing sage infusion, warm and herbal.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['tea_earl_grey'] = {
		label = 'Earl Grey Tea',
		description = 'Black tea perfumed with bergamot oil.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['tea_hibiskus'] = {
		label = 'Hibiscus Tea',
		description = 'Deep red hibiscus tea, floral and tart.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['tea_ihlamur'] = {
		label = 'Linden Tea',
		description = 'Linden blossom tea; calming on a cold night.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['tea_kiwi'] = {
		label = 'Kiwi Tea',
		description = 'Fruity kiwi infusion, light and tangy.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['tea_kusburnu'] = {
		label = 'Rosehip Tea',
		description = 'Rosehip tea, sharp with vitamin C.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['tea_nane'] = {
		label = 'Mint Tea',
		description = 'Fresh mint tea that clears the head.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['tea_oralet'] = {
		label = 'Oralet Tea',
		description = 'Instant fruit tea, sweet and nostalgic.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['tea_papatya'] = {
		label = 'Chamomile Tea',
		description = 'Chamomile infusion for a slow evening.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['tea_yesil'] = {
		label = 'Green Tea',
		description = 'Grassy green tea, light and clean.',
		category = 'drinks',
		weight = 150,
		stack = true,
		close = true,
	},

	['tequila_sunrise'] = {
		label = 'Tequila Sunrise',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['tom_collins'] = {
		label = 'Tom Collins',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['tomato_juice'] = {
		label = 'Tomato Juice',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['vodka'] = {
		label = 'Vodka',
		description = 'For all the thirsty out there',
		category = 'drinks',
		weight = 500,
		stack = true,
		close = true,
		client = { image = 'vodka.png' },
	},

	['water'] = {
		label = 'Water bottle',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = true,
		close = true,
		consume = 1,
		client = {
			image = 'water.png',
			status = { thirst = 200000 },
			anim = { clip = 'loop_bottle', dict = 'mp_player_intdrink' },
			prop = {
				bone = 60309,
				model = 'vw_prop_casino_water_bottle_01a',
				pos = vec3(0.0, 0.0, -0.05000000074505),
				rot = vec3(0.0, 0.0, -40.0),
			},
			usetime = 2500,
		},
	},

	['water_bottle'] = {
		label = 'Water bottle',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = true,
		close = true,
		consume = 1,
		client = {
			image = 'water_bottle.png',
			status = { thirst = 10000 },
			anim = { clip = 'loop_bottle', dict = 'mp_player_intdrink', flag = 49 },
			prop = {
				bone = 60309,
				model = 'vw_prop_casino_water_bottle_01a',
				pos = vec3(0.0, 0.0, -0.05000000074505),
				rot = vec3(0.0, 0.0, -40.0),
			},
			usetime = 2500,
		},
	},

	['watermelon_juice'] = {
		label = 'Watermelon Juice',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['whiskey'] = {
		label = 'Whiskey',
		description = 'For all the thirsty out there',
		category = 'drinks',
		weight = 500,
		stack = true,
		close = true,
		client = { image = 'whiskey.png' },
	},

	['whiskey_bottle'] = {
		label = 'Whiskey Bottle',
		description = 'Unopened bottle of whiskey.',
		category = 'drinks',
		weight = 800,
		stack = true,
		close = true,
	},

	['white'] = {
		label = 'White',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	['wine'] = {
		label = 'Wine',
		description = 'Some good wine to drink on a fine evening',
		category = 'drinks',
		weight = 300,
		stack = true,
		close = false,
		client = { image = 'wine.png' },
	},

	['zifandel'] = {
		label = 'Zifandel',
		description = '',
		category = 'drinks',
		weight = 100,
		stack = false,
		close = false,
	},

	-- Ingredients and kitchenware (85)
	['alive_chicken'] = {
		label = 'Living chicken',
		category = 'ingredients',
		weight = 1,
		stack = true,
		close = true,
	},

	['apple'] = {
		label = 'Apple',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['avokado'] = {
		label = 'Avokado',
		description = '',
		category = 'ingredients',
		weight = 500,
		stack = true,
		close = false,
	},

	['banana'] = {
		label = 'Banana',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['berry'] = {
		label = 'Berry',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['blueberry'] = {
		label = 'Blueberry',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['burgerbread'] = {
		label = 'Burger Bread',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['caramel'] = {
		label = 'Caramel',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['carrot'] = {
		label = 'Carrot',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['cheddarcheese'] = {
		label = 'Cheddar Cheese',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['cheese'] = {
		label = 'Pizza Cheese',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['cheese2'] = {
		label = 'Cut Pizza Cheese',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['cherry'] = {
		label = 'Cherry',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['chicken'] = {
		label = 'Chicken',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['coconut'] = {
		label = 'Coconut',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['coffee_cup'] = {
		label = 'Empty Coffee Cup',
		description = 'A clean porcelain coffee cup. Waiting to be filled.',
		category = 'ingredients',
		weight = 180,
		stack = true,
		close = true,
	},

	['coffee_saucer'] = {
		label = 'Coffee Saucer',
		description = 'A porcelain saucer for a coffee cup.',
		category = 'ingredients',
		weight = 140,
		stack = true,
		close = true,
	},

	['cranberry'] = {
		label = 'Cranberry',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['cucumber'] = {
		label = 'Cucumber',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['cup'] = {
		label = 'Cup',
		description = 'Tea/coffee cup.',
		category = 'ingredients',
		weight = 250,
		stack = true,
		close = true,
	},

	['dough'] = {
		label = 'Dough',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['dough2'] = {
		label = 'Dough',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['egg'] = {
		label = 'Eggs',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['fish'] = {
		label = 'Fish',
		category = 'ingredients',
		weight = 1,
		stack = true,
		close = true,
	},

	['flour'] = {
		label = 'Flour',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['food_mushroom'] = {
		label = 'Mushroom',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['grape'] = {
		label = 'Grape',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
		client = { image = 'grape.png' },
	},

	['grapefruit'] = {
		label = 'Greyfurt',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['guacamolesauce'] = {
		label = 'Guacamole Sauce',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['ice'] = {
		label = 'Ice',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['ketchup'] = {
		label = 'Ketchup',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['kiwi'] = {
		label = 'Kiwi',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['lemon'] = {
		label = 'Lemon',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['lettuce'] = {
		label = 'Lettuce',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['lettuce2'] = {
		label = 'Cut Lettuce',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['lime'] = {
		label = 'Lime',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['maracuja'] = {
		label = 'Maracuja',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['mayonnaise'] = {
		label = 'Mayonnaise',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['meat'] = {
		label = 'Raw Meat',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['meat2'] = {
		label = 'Cooked Meat',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['mint'] = {
		label = 'Mint',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['miso'] = {
		label = 'Miso Soup',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = false,
		close = true,
	},

	['mustard'] = {
		label = 'Mustard',
		description = '',
		category = 'ingredients',
		tier = 'snack',
		weight = 100,
		stack = true,
		close = true,
		consume = 1,
		client = {
			image = 'mustard.png',
			status = { hunger = 25000, thirst = 25000 },
			anim = { clip = 'loop_bottle', dict = 'mp_player_intdrink' },
			prop = {
				model = 1453189379,
				pos = vec3(0.01, 0.0, -0.07),
				rot = vec3(1.0, 1.0, -1.5),
			},
			usetime = 2500,
			notification = 'You.. drank mustard',
		},
	},

	['noodles'] = {
		label = 'Noodle',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['nori'] = {
		label = 'Nori',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['onion'] = {
		label = 'Onion',
		description = '',
		category = 'ingredients',
		weight = 500,
		stack = true,
		close = false,
	},

	['orange'] = {
		label = 'Orange',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['packaged_chicken'] = {
		label = 'Chicken fillet',
		category = 'ingredients',
		weight = 1,
		stack = true,
		close = true,
	},

	['peach'] = {
		label = 'Peach',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['pear'] = {
		label = 'Pear',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['pepper'] = {
		label = 'Pepper',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['pickle'] = {
		label = 'Pickle',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['pickle2'] = {
		label = 'Cut Pickle',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['pineapple'] = {
		label = 'Pineapple',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['plate'] = {
		label = 'Plate',
		description = 'Porcelain plate.',
		category = 'ingredients',
		weight = 400,
		stack = true,
		close = true,
	},

	['plum'] = {
		label = 'Plum',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['potato'] = {
		label = 'Potato',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['potato2'] = {
		label = 'Cut Potato',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['raw_chickenpizza'] = {
		label = 'Raw Chicken Pizza',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['raw_margaritapizza'] = {
		label = 'Raw Margaritalı Pizza',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['raw_mushroompizza'] = {
		label = 'Raw Mushroom Pizza',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['raw_sausagepizza'] = {
		label = 'Raw Sausage Pizza',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['raw_tunapizza'] = {
		label = 'Raw Tuna Pizza',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['rawcoffee'] = {
		label = 'Raw Coffee',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['rice'] = {
		label = 'Rice',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['sandwichbread'] = {
		label = 'Sandwich Bread',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['sausage'] = {
		label = 'Sausage',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['sausage_brat'] = {
		label = 'Sausage',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['silverware'] = {
		label = 'Silverware',
		description = 'Silver-plated cutlery set.',
		category = 'ingredients',
		weight = 800,
		stack = true,
		close = true,
	},

	['slaughtered_chicken'] = {
		label = 'Slaughtered chicken',
		category = 'ingredients',
		weight = 1,
		stack = true,
		close = true,
	},

	['spice'] = {
		label = 'Spice',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['strawberry'] = {
		label = 'Strawberry',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['sugar'] = {
		label = 'Sugar',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['tacosauce'] = {
		label = 'Taco Sauce',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['tea_glass'] = {
		label = 'Tea Glass',
		description = 'A slim tulip glass of Turkish tea.',
		category = 'ingredients',
		weight = 110,
		stack = true,
		close = true,
	},

	['tea_glass_handle'] = {
		label = 'Tea Glass with Handle',
		description = 'A tulip tea glass set in a handled holder so you do not burn your fingers.',
		category = 'ingredients',
		weight = 140,
		stack = true,
		close = true,
	},

	['tea_saucer'] = {
		label = 'Tea Saucer',
		description = 'A small saucer for a tulip tea glass, with room for two sugar cubes.',
		category = 'ingredients',
		weight = 90,
		stack = true,
		close = true,
	},

	['tofu'] = {
		label = 'Tofu',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['tomatoes'] = {
		label = 'Tomato',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['tomatoes2'] = {
		label = 'Cut Tomato',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['tomatopaste'] = {
		label = 'Tomatopaste',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['tortilla'] = {
		label = 'Tortilla',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = true,
	},

	['tuna'] = {
		label = 'Tuna',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['vanilla'] = {
		label = 'Vanilya',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	['watermelon'] = {
		label = 'Watermelon',
		description = '',
		category = 'ingredients',
		weight = 100,
		stack = true,
		close = false,
	},

	-- Medical (20)
	['bandage'] = {
		label = 'Bandage',
		description = 'A bandage works every time',
		category = 'medical',
		weight = 0,
		stack = false,
		close = true,
		client = { image = 'bandage.png' },
	},

	['burncream'] = {
		label = 'Maść na oparzenia',
		description = 'Used to treat burns',
		category = 'medical',
		weight = 10,
		stack = false,
		close = true,
		client = { image = 'burncream.png' },
	},

	['defibrillator'] = {
		label = 'Defibrylator',
		description = 'A reusable defibrillator for reviving downed patients',
		category = 'medical',
		weight = 2500,
		stack = false,
		close = true,
		client = { image = 'defibrillator.png' },
	},

	['firstaid'] = {
		label = 'First Aid',
		description = 'You can use this First Aid kit to get people back on their feet',
		category = 'medical',
		weight = 2500,
		stack = true,
		close = true,
		client = { image = 'firstaid.png' },
	},

	['firstaidkit'] = {
		label = 'Zestaw pierwszej pomocy',
		description = 'A comprehensive first aid kit for serious injuries',
		category = 'medical',
		weight = 350,
		stack = false,
		close = true,
		client = { image = 'firstaidkit.png' },
	},

	['forceps'] = {
		label = 'Kleszczyki chirurgiczne',
		description = 'Used to treat gunshot wounds',
		category = 'medical',
		weight = 100,
		stack = false,
		close = true,
		client = { image = 'forceps.png' },
	},

	['icepack'] = {
		label = 'Zimny okład',
		description = 'Used to treat punches and bruises',
		category = 'medical',
		weight = 25,
		stack = false,
		close = true,
		client = { image = 'icepack.png' },
	},

	['ifak'] = {
		label = 'Indywidualny zestaw medyczny',
		description = 'Individual First Aid Kit',
		category = 'medical',
		weight = 150,
		stack = false,
		close = true,
		client = { image = 'ifak.png' },
	},

	['ifaks'] = {
		label = 'ifaks',
		description = 'ifaks for healing and a complete stress remover.',
		category = 'medical',
		weight = 200,
		stack = true,
		close = true,
		client = { image = 'ifaks.png' },
	},

	['medbag'] = {
		label = 'Torba medyczna',
		description = 'A portable medical bag containing supplies',
		category = 'medical',
		weight = 50,
		stack = false,
		close = true,
		client = { image = 'medbag.png' },
	},

	['medikit'] = {
		label = 'Medikit',
		category = 'medical',
		weight = 2,
		stack = true,
		close = true,
	},

	['medkit'] = {
		label = 'Apteczka medyczna',
		description = 'A medical kit for treating injuries',
		category = 'medical',
		weight = 250,
		stack = false,
		close = true,
		client = { image = 'medkit.png' },
	},

	['painkillers'] = {
		label = 'Painkillers',
		description = 'For pain you can\'t stand anymore, take this pill that\'d make you feel great again',
		category = 'medical',
		weight = 0,
		stack = false,
		close = true,
		client = { image = 'painkillers.png' },
	},

	['sedative'] = {
		label = 'Środek uspokajający',
		description = 'A controlled sedative for EMS use',
		category = 'medical',
		weight = 25,
		stack = false,
		close = true,
		client = { image = 'sedative.png' },
	},

	['splint'] = {
		label = 'Szyna',
		description = 'Used to treat broken bones',
		category = 'medical',
		weight = 50,
		stack = false,
		close = true,
		client = { image = 'splint.png' },
	},

	['suture'] = {
		label = 'Szwy chirurgiczne',
		description = 'Used to treat cuts',
		category = 'medical',
		weight = 25,
		stack = false,
		close = true,
		client = { image = 'suture.png' },
	},

	['testbandage'] = {
		label = 'Bandage',
		description = '',
		category = 'medical',
		weight = 115,
		stack = true,
		close = true,
		client = {
			anim = {
				clip = 'idle_a',
				dict = 'missheistdockssetup1clipboard@idle_a',
				flag = 49,
			},
			prop = {
				model = 'prop_rolled_sock_02',
				pos = vec3(-0.14, -0.14, -0.08),
				rot = vec3(-50.0, -50.0, 0.0),
			},
			usetime = 2500,
			disable = { car = true, combat = true, move = true },
		},
	},

	['tissues'] = {
		label = 'Tissues',
		description = 'Box of paper tissues.',
		category = 'medical',
		weight = 100,
		stack = true,
		close = true,
	},

	['traumakit'] = {
		label = 'Zestaw urazowy',
		description = 'Used to treat blunt force trauma',
		category = 'medical',
		weight = 75,
		stack = false,
		close = true,
		client = { image = 'traumakit.png' },
	},

	['walkstick'] = {
		label = 'Walking Stick',
		description = 'Walking stick for ya\'ll grannies out there.. HAHA',
		category = 'medical',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'walkstick.png' },
	},

	-- Drugs (27)
	['bong'] = {
		label = 'Bong',
		description = 'Glass bong.',
		category = 'drugs',
		weight = 1500,
		stack = true,
		close = true,
	},

	['cannabis'] = {
		label = 'Cannabis',
		category = 'drugs',
		weight = 3,
		stack = true,
		close = true,
	},

	['coke_brick'] = {
		label = 'Coke Brick',
		description = 'Heavy package of cocaine, mostly used for deals and takes a lot of space',
		category = 'drugs',
		weight = 1000,
		stack = false,
		close = true,
		client = { image = 'coke_brick.png' },
	},

	['coke_small_brick'] = {
		label = 'Coke Package',
		description = 'Small package of cocaine, mostly used for deals and takes a lot of space',
		category = 'drugs',
		weight = 350,
		stack = false,
		close = true,
		client = {
			image = 'coke_small_brick.png',
		},
	},

	['cokebaggy'] = {
		label = 'Bag of Coke',
		description = 'To get happy real quick',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
	},

	['crack_baggy'] = {
		label = 'Bag of Crack',
		description = 'To get happy faster',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
		client = { image = 'crack_baggy.png' },
	},

	['empty_weed_bag'] = {
		label = 'Empty Weed Bag',
		description = 'A small empty bag',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
	},

	['joint'] = {
		label = 'Joint',
		description = 'Sidney would be very proud at you',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
		client = { image = 'joint.png' },
	},

	['marijuana'] = {
		label = 'Marijuana',
		category = 'drugs',
		weight = 2,
		stack = true,
		close = true,
	},

	['meth'] = {
		label = 'Meth',
		description = 'A baggie of Meth',
		category = 'drugs',
		weight = 100,
		stack = true,
		close = true,
		client = { image = 'meth.png' },
	},

	['oxy'] = {
		label = 'Prescription Oxy',
		description = 'The Label Has Been Ripped Off',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
		client = { image = 'oxy.png' },
	},

	['rolling_paper'] = {
		label = 'Rolling Paper',
		description = 'Paper made specifically for encasing and smoking tobacco or cannabis.',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
		client = { image = 'rolling_paper.png' },
	},

	['weed_ak47'] = {
		label = 'AK47 2g',
		description = 'A weed bag with 2g AK47',
		category = 'drugs',
		weight = 200,
		stack = true,
		close = false,
	},

	['weed_ak47_seed'] = {
		label = 'AK47 Seed',
		description = 'A weed seed of AK47',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
	},

	['weed_amnesia'] = {
		label = 'Amnesia 2g',
		description = 'A weed bag with 2g Amnesia',
		category = 'drugs',
		weight = 200,
		stack = true,
		close = false,
	},

	['weed_amnesia_seed'] = {
		label = 'Amnesia Seed',
		description = 'A weed seed of Amnesia',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
	},

	['weed_brick'] = {
		label = 'Weed Brick',
		description = '1KG Weed Brick to sell to large customers.',
		category = 'drugs',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'weed_brick.png' },
	},

	['weed_nutrition'] = {
		label = 'Plant Fertilizer',
		description = 'Plant nutrition',
		category = 'drugs',
		weight = 2000,
		stack = true,
		close = true,
		client = {
			image = 'weed_nutrition.png',
		},
	},

	['weed_ogkush'] = {
		label = 'OGKush 2g',
		description = 'A weed bag with 2g OG Kush',
		category = 'drugs',
		weight = 200,
		stack = true,
		close = false,
	},

	['weed_ogkush_seed'] = {
		label = 'OGKush Seed',
		description = 'A weed seed of OG Kush',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
	},

	['weed_purplehaze'] = {
		label = 'Purple Haze 2g',
		description = 'A weed bag with 2g Purple Haze',
		category = 'drugs',
		weight = 200,
		stack = true,
		close = false,
	},

	['weed_purplehaze_seed'] = {
		label = 'Purple Haze Seed',
		description = 'A weed seed of Purple Haze',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
	},

	['weed_skunk'] = {
		label = 'Skunk 2g',
		description = 'A weed bag with 2g Skunk',
		category = 'drugs',
		weight = 200,
		stack = true,
		close = false,
	},

	['weed_skunk_seed'] = {
		label = 'Skunk Seed',
		description = 'A weed seed of Skunk',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
	},

	['weed_whitewidow'] = {
		label = 'White Widow 2g',
		description = 'A weed bag with 2g White Widow',
		category = 'drugs',
		weight = 200,
		stack = true,
		close = false,
	},

	['weed_whitewidow_seed'] = {
		label = 'White Widow Seed',
		description = 'A weed seed of White Widow',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = false,
	},

	['xtcbaggy'] = {
		label = 'Bag of XTC',
		description = 'Pop those pills baby',
		category = 'drugs',
		weight = 0,
		stack = true,
		close = true,
	},

	-- Vehicle parts, tuning and fuel (129)
	['actuator'] = {
		label = 'Actuator',
		description = 'Wastegate actuator',
		category = 'vehicle',
		weight = 250,
		stack = true,
		close = true,
	},

	['advancedrepairkit'] = {
		label = 'Advanced Repairkit',
		description = 'A nice toolbox with stuff to repair your vehicle',
		category = 'vehicle',
		weight = 4000,
		stack = true,
		close = true,
	},

	['air_filter'] = {
		label = 'Air Filter',
		description = 'High flow air filter',
		category = 'vehicle',
		weight = 300,
		stack = true,
		close = true,
	},

	['awd_drivetrain'] = {
		label = 'AWD Drivetrain',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['axle'] = {
		label = 'Axle',
		description = 'Drive axle',
		category = 'vehicle',
		weight = 1500,
		stack = true,
		close = true,
	},

	['body_part'] = {
		label = 'Body Part',
		description = 'Body repair part',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
	},

	['brake_disc'] = {
		label = 'Brake Disc',
		description = 'Vented brake disc',
		category = 'vehicle',
		weight = 800,
		stack = true,
		close = true,
	},

	['brake_drum'] = {
		label = 'Brake Drum',
		description = 'Brake drum',
		category = 'vehicle',
		weight = 900,
		stack = true,
		close = true,
	},

	['brake_part_1'] = {
		label = 'Brake Upgrade 1',
		description = 'Stage 1 brake upgrade kit',
		category = 'vehicle',
		weight = 3000,
		stack = true,
		close = true,
	},

	['brake_part_2'] = {
		label = 'Brake Upgrade 2',
		description = 'Stage 2 brake upgrade kit',
		category = 'vehicle',
		weight = 3000,
		stack = true,
		close = true,
	},

	['brake_part_3'] = {
		label = 'Brake Upgrade 3',
		description = 'Stage 3 brake upgrade kit',
		category = 'vehicle',
		weight = 3000,
		stack = true,
		close = true,
	},

	['brake_part_4'] = {
		label = 'Brake Upgrade 4',
		description = 'Stage 4 brake upgrade kit',
		category = 'vehicle',
		weight = 3000,
		stack = true,
		close = true,
	},

	['brake_part_5'] = {
		label = 'Brake Upgrade 5',
		description = 'Stage 5 brake upgrade kit',
		category = 'vehicle',
		weight = 3000,
		stack = true,
		close = true,
	},

	['brake_shoe'] = {
		label = 'Brake Shoe',
		description = 'Brake shoe',
		category = 'vehicle',
		weight = 300,
		stack = true,
		close = true,
	},

	['brakepad_replacement'] = {
		label = 'Brakepad Replacement',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['bulletproof_tyres'] = {
		label = 'Bulletproof Tyres',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['car_key'] = {
		label = 'Car Key',
		description = '',
		category = 'vehicle',
		weight = 100,
		stack = true,
		close = true,
	},

	['carokit'] = {
		label = 'Body Kit',
		category = 'vehicle',
		weight = 3,
		stack = true,
		close = true,
	},

	['carotool'] = {
		label = 'Tools',
		category = 'vehicle',
		weight = 2,
		stack = true,
		close = true,
	},

	['ceramic_brakes'] = {
		label = 'Ceramic Brakes',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['cleaning_kit'] = {
		label = 'Cleaning Kit',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['cleaningkit'] = {
		label = 'Cleaning Kit',
		description = 'A microfiber cloth with some soap will let your car sparkle again!',
		category = 'vehicle',
		weight = 250,
		stack = true,
		close = true,
		client = { image = 'cleaningkit.png' },
	},

	['clutch_replacement'] = {
		label = 'Clutch Replacement',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['cosmetic_part'] = {
		label = 'Cosmetic Parts',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['drift_tuning_kit'] = {
		label = 'Drift Tuning Kit',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['empty_nitrous_bottle'] = {
		label = 'Empty Nitrous Bottle',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['engine_block'] = {
		label = 'Engine Block',
		description = 'Bare engine block, the base of every engine build',
		category = 'vehicle',
		weight = 4000,
		stack = true,
		close = true,
	},

	['engine_condition_kit'] = {
		label = 'Engine Condition Kit',
		description = 'Restores the engine condition of a worn vehicle',
		category = 'vehicle',
		weight = 3000,
		stack = true,
		close = true,
	},

	['engine_oil'] = {
		label = 'Engine Oil',
		description = 'Engine oil for the service',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
	},

	['engine_part'] = {
		label = 'Engine Part',
		description = 'Engine repair part',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
	},

	['engine_part_1'] = {
		label = 'Engine Upgrade 1',
		description = 'Stage 1 engine upgrade kit',
		category = 'vehicle',
		weight = 5000,
		stack = true,
		close = true,
	},

	['engine_part_2'] = {
		label = 'Engine Upgrade 2',
		description = 'Stage 2 engine upgrade kit',
		category = 'vehicle',
		weight = 5000,
		stack = true,
		close = true,
	},

	['engine_part_3'] = {
		label = 'Engine Upgrade 3',
		description = 'Stage 3 engine upgrade kit',
		category = 'vehicle',
		weight = 5000,
		stack = true,
		close = true,
	},

	['engine_part_4'] = {
		label = 'Engine Upgrade 4',
		description = 'Stage 4 engine upgrade kit',
		category = 'vehicle',
		weight = 5000,
		stack = true,
		close = true,
	},

	['engine_part_5'] = {
		label = 'Engine Upgrade 5',
		description = 'Stage 5 engine upgrade kit',
		category = 'vehicle',
		weight = 5000,
		stack = true,
		close = true,
	},

	['engine_repair_kit'] = {
		label = 'Engine Repair Kit',
		description = 'Fixes the engine of a vehicle',
		category = 'vehicle',
		weight = 2500,
		stack = true,
		close = true,
	},

	['essence'] = {
		label = 'Gas',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['ev_battery'] = {
		label = 'EV Battery',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['ev_coolant'] = {
		label = 'EV Coolant',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['ev_motor'] = {
		label = 'EV Motor',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['extras_kit'] = {
		label = 'Extras Kit',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['fixkit'] = {
		label = 'Repair Kit',
		category = 'vehicle',
		weight = 3,
		stack = true,
		close = true,
	},

	['fixtool'] = {
		label = 'Repair Tools',
		category = 'vehicle',
		weight = 2,
		stack = true,
		close = true,
	},

	['full_repair_kit'] = {
		label = 'Full Repair Kit',
		description = 'Fixes everything on a vehicle except the dirt',
		category = 'vehicle',
		weight = 5000,
		stack = true,
		close = true,
	},

	['fwd_drivetrain'] = {
		label = 'FWD Drivetrain',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['gas_tank_part'] = {
		label = 'Gas Tank Part',
		description = 'Fuel tank repair part',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
	},

	['gazbottle'] = {
		label = 'Gas Bottle',
		category = 'vehicle',
		weight = 2,
		stack = true,
		close = true,
	},

	['gear_cable'] = {
		label = 'Gear Cable',
		description = 'Gear shift cable',
		category = 'vehicle',
		weight = 200,
		stack = true,
		close = true,
	},

	['gear_cog'] = {
		label = 'Gear Cog',
		description = 'Transmission gear cog',
		category = 'vehicle',
		weight = 350,
		stack = true,
		close = true,
	},

	['gear_lever'] = {
		label = 'Gear Lever',
		description = 'Gear lever',
		category = 'vehicle',
		weight = 300,
		stack = true,
		close = true,
	},

	['gearbox_part'] = {
		label = 'Gearbox Part',
		description = 'Gearbox repair part',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
	},

	['gearbox_part_1'] = {
		label = 'Gearbox Upgrade 1',
		description = 'Stage 1 gearbox upgrade kit',
		category = 'vehicle',
		weight = 4000,
		stack = true,
		close = true,
	},

	['gearbox_part_2'] = {
		label = 'Gearbox Upgrade 2',
		description = 'Stage 2 gearbox upgrade kit',
		category = 'vehicle',
		weight = 4000,
		stack = true,
		close = true,
	},

	['gearbox_part_3'] = {
		label = 'Gearbox Upgrade 3',
		description = 'Stage 3 gearbox upgrade kit',
		category = 'vehicle',
		weight = 4000,
		stack = true,
		close = true,
	},

	['gearbox_part_4'] = {
		label = 'Gearbox Upgrade 4',
		description = 'Stage 4 gearbox upgrade kit',
		category = 'vehicle',
		weight = 4000,
		stack = true,
		close = true,
	},

	['gearbox_part_5'] = {
		label = 'Gearbox Upgrade 5',
		description = 'Stage 5 gearbox upgrade kit',
		category = 'vehicle',
		weight = 4000,
		stack = true,
		close = true,
	},

	['harness'] = {
		label = 'Race Harness',
		description = 'Racing Harness so no matter what you stay in the car',
		category = 'vehicle',
		weight = 1000,
		stack = false,
		close = true,
		client = { image = 'harness.png' },
	},

	['i4_engine'] = {
		label = 'I4 Engine',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['jerry_can'] = {
		label = 'Jerrycan 20L',
		description = 'A can full of Fuel',
		category = 'vehicle',
		weight = 20000,
		stack = true,
		close = true,
		client = { image = 'jerry_can.png' },
	},

	['kluczyk'] = {
		label = 'Kluczyki do pojazdu',
		description = 'Kluczyki do jednego pojazdu. W metadanych zapisana jest rejestracja (pole plate / rejestracja).',
		category = 'vehicle',
		weight = 50,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'labkey.png',
			export = 'ms_inventory.useKey',
		},
	},

	['lights_part'] = {
		label = 'Lights Part',
		description = 'Vehicle lights repair part',
		category = 'vehicle',
		weight = 500,
		stack = true,
		close = true,
	},

	['manual_gearbox'] = {
		label = 'Manual Gearbox',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['mechanic_tablet'] = {
		label = 'Mechanic Tablet',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['mileage_part'] = {
		label = 'Odometer Part',
		description = 'Workshop odometer service part',
		category = 'vehicle',
		weight = 800,
		stack = true,
		close = true,
	},

	['nitrous'] = {
		label = 'Nitrous',
		description = 'Speed up, gas pedal! :D',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'nitrous.png' },
	},

	['nitrous_bottle'] = {
		label = 'Nitrous Bottle',
		description = 'Filled nitrous bottle, installed at the vehicle',
		category = 'vehicle',
		weight = 2500,
		stack = true,
		close = true,
	},

	['nitrous_gas'] = {
		label = 'Nitrous Gas',
		description = 'Nitrous gas, refills a bottle at the mechanic',
		category = 'vehicle',
		weight = 1500,
		stack = true,
		close = true,
	},

	['nitrous_install_kit'] = {
		label = 'Nitrous Install Kit',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['offroad_tyres'] = {
		label = 'Offroad Tyres',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['oil_filter'] = {
		label = 'Oil Filter',
		description = 'Oil filter for the service',
		category = 'vehicle',
		weight = 300,
		stack = true,
		close = true,
	},

	['performance_part'] = {
		label = 'Performance Parts',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['petrol'] = {
		label = 'Oil',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['petrol_raffin'] = {
		label = 'Processed oil',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['piston'] = {
		label = 'Piston',
		description = 'Forged piston',
		category = 'vehicle',
		weight = 300,
		stack = true,
		close = true,
	},

	['piston_rod'] = {
		label = 'Piston Rod',
		description = 'Connecting rod',
		category = 'vehicle',
		weight = 250,
		stack = true,
		close = true,
	},

	['radiator_part'] = {
		label = 'Radiator Part',
		description = 'Radiator repair part',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
	},

	['repair_kit'] = {
		label = 'Vehicle Repair Kit',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['repairkit'] = {
		label = 'Repairkit',
		description = 'A nice toolbox with stuff to repair your vehicle',
		category = 'vehicle',
		weight = 2500,
		stack = true,
		close = true,
		client = { image = 'repairkit.png' },
	},

	['respray_kit'] = {
		label = 'Respray Kit',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['runbooster'] = {
		label = 'Run-Booster',
		description = 'Suplement ulatwiajacy bieganie i poprawiajacy wytrzymalosc.',
		category = 'vehicle',
		weight = 200,
		stack = true,
		close = true,
		client = { image = 'runbooster.png' },
	},

	['rwd_drivetrain'] = {
		label = 'RWD Drivetrain',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['semi_slick_tyres'] = {
		label = 'Semi Slick Tyres',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['slick_tyres'] = {
		label = 'Slick Tyres',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['spark_plug'] = {
		label = 'Spark Plug',
		description = 'Single spark plug for engine builds',
		category = 'vehicle',
		weight = 100,
		stack = true,
		close = true,
	},

	['spark_plugs'] = {
		label = 'Spark Plugs',
		description = 'Set of spark plugs for the service',
		category = 'vehicle',
		weight = 400,
		stack = true,
		close = true,
	},

	['stancing_kit'] = {
		label = 'Stance Kit',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['suspension_part_1'] = {
		label = 'Suspension Upgrade 1',
		description = 'Stage 1 suspension upgrade kit',
		category = 'vehicle',
		weight = 3500,
		stack = true,
		close = true,
	},

	['suspension_part_2'] = {
		label = 'Suspension Upgrade 2',
		description = 'Stage 2 suspension upgrade kit',
		category = 'vehicle',
		weight = 3500,
		stack = true,
		close = true,
	},

	['suspension_part_3'] = {
		label = 'Suspension Upgrade 3',
		description = 'Stage 3 suspension upgrade kit',
		category = 'vehicle',
		weight = 3500,
		stack = true,
		close = true,
	},

	['suspension_part_4'] = {
		label = 'Suspension Upgrade 4',
		description = 'Stage 4 suspension upgrade kit',
		category = 'vehicle',
		weight = 3500,
		stack = true,
		close = true,
	},

	['suspension_part_5'] = {
		label = 'Suspension Upgrade 5',
		description = 'Stage 5 suspension upgrade kit',
		category = 'vehicle',
		weight = 3500,
		stack = true,
		close = true,
	},

	['suspension_parts'] = {
		label = 'Suspension Parts',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['suspension_spring'] = {
		label = 'Suspension Spring',
		description = 'Coil spring',
		category = 'vehicle',
		weight = 600,
		stack = true,
		close = true,
	},

	['synchro_ring'] = {
		label = 'Synchro Ring',
		description = 'Synchromesh ring',
		category = 'vehicle',
		weight = 150,
		stack = true,
		close = true,
	},

	['tie_rod'] = {
		label = 'Tie Rod',
		description = 'Steering tie rod',
		category = 'vehicle',
		weight = 400,
		stack = true,
		close = true,
	},

	['tint_meter'] = {
		label = 'Tint Meter',
		description = '',
		category = 'vehicle',
		weight = 100,
		stack = true,
		close = true,
	},

	['tint_remover'] = {
		label = 'Tint Remover Tool',
		description = '',
		category = 'vehicle',
		weight = 100,
		stack = true,
		close = true,
	},

	['tirerepairkit'] = {
		label = 'Tire Repair Kit',
		description = 'A kit to repair your tires',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'tirerepairkit.png' },
	},

	['towrope'] = {
		label = 'Tow Rope',
		description = 'Heavy duty rope with a hook, used to tow vehicles',
		category = 'vehicle',
		weight = 2000,
		stack = true,
		close = true,
	},

	['tunerlaptop'] = {
		label = 'Tunerchip',
		description = 'With this tunerchip you can get your car on steroids... If you know what you\'re doing',
		category = 'vehicle',
		weight = 2000,
		stack = false,
		close = true,
	},

	['turbo_backplate'] = {
		label = 'Turbo Backplate',
		description = 'Turbo backplate',
		category = 'vehicle',
		weight = 250,
		stack = true,
		close = true,
	},

	['turbo_body'] = {
		label = 'Turbo Body',
		description = 'Turbocharger center body',
		category = 'vehicle',
		weight = 900,
		stack = true,
		close = true,
	},

	['turbo_chra'] = {
		label = 'Turbo CHRA',
		description = 'Turbo core assembly',
		category = 'vehicle',
		weight = 600,
		stack = true,
		close = true,
	},

	['turbo_volute'] = {
		label = 'Turbo Volute',
		description = 'Turbo volute housing',
		category = 'vehicle',
		weight = 700,
		stack = true,
		close = true,
	},

	['turbocharger'] = {
		label = 'Turbocharger',
		description = 'Complete bolt-on turbocharger',
		category = 'vehicle',
		weight = 6000,
		stack = true,
		close = true,
	},

	['tyre_repair_kit'] = {
		label = 'Tyre Repair Kit',
		description = 'Fixes the tyres of a vehicle',
		category = 'vehicle',
		weight = 2000,
		stack = true,
		close = true,
	},

	['tyre_replacement'] = {
		label = 'Tyre Replacement',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['tyre_smoke_kit'] = {
		label = 'Tyre Smoke Kit',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['v12_engine'] = {
		label = 'V12 Engine',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['v6_engine'] = {
		label = 'V6 Engine',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['v8_engine'] = {
		label = 'V8 Engine',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['veh_armor'] = {
		label = 'Armor',
		description = 'Upgrade vehicle armor',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_armor.png' },
	},

	['veh_brakes'] = {
		label = 'Brakes',
		description = 'Upgrade vehicle brakes',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_brakes.png' },
	},

	['veh_engine'] = {
		label = 'Engine',
		description = 'Upgrade vehicle engine',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_engine.png' },
	},

	['veh_exterior'] = {
		label = 'Exterior',
		description = 'Upgrade vehicle exterior',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_exterior.png' },
	},

	['veh_interior'] = {
		label = 'Interior',
		description = 'Upgrade vehicle interior',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_interior.png' },
	},

	['veh_neons'] = {
		label = 'Neons',
		description = 'Upgrade vehicle neons',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_neons.png' },
	},

	['veh_plates'] = {
		label = 'Plates',
		description = 'Install vehicle plates',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_plates.png' },
	},

	['veh_suspension'] = {
		label = 'Suspension',
		description = 'Upgrade vehicle suspension',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			image = 'veh_suspension.png',
		},
	},

	['veh_tint'] = {
		label = 'Tints',
		description = 'Install vehicle tint',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_tint.png' },
	},

	['veh_toolbox'] = {
		label = 'Toolbox',
		description = 'Check vehicle status',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_toolbox.png' },
	},

	['veh_transmission'] = {
		label = 'Transmission',
		description = 'Upgrade vehicle transmission',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			image = 'veh_transmission.png',
		},
	},

	['veh_turbo'] = {
		label = 'Turbo',
		description = 'Install vehicle turbo',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_turbo.png' },
	},

	['veh_wheels'] = {
		label = 'Wheels',
		description = 'Upgrade vehicle wheels',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_wheels.png' },
	},

	['veh_xenons'] = {
		label = 'Xenons',
		description = 'Upgrade vehicle xenons',
		category = 'vehicle',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'veh_xenons.png' },
	},

	['vehicle_wheels'] = {
		label = 'Vehicle Wheels Set',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	['wastegate'] = {
		label = 'Wastegate',
		description = 'External wastegate',
		category = 'vehicle',
		weight = 300,
		stack = true,
		close = true,
	},

	['wheel_clamp'] = {
		label = 'Blokada na koło',
		category = 'vehicle',
		weight = 3,
		stack = true,
		close = true,
	},

	['wheel_clamp_wrench'] = {
		label = 'Klucz do blokady',
		category = 'vehicle',
		weight = 1,
		stack = true,
		close = true,
	},

	-- Tools, electronics and equipment (117)
	['advanced_lockpick'] = {
		label = 'Advanced Lockpick',
		description = 'Cracks high-end locks and safes. Wears down on every use.',
		category = 'tools',
		weight = 500,
		stack = false,
		close = true,
	},

	['advancedlockpick'] = {
		label = 'Advanced Lockpick',
		description = 'If you lose your keys a lot this is very useful... Also useful to open your beers',
		category = 'tools',
		weight = 500,
		stack = true,
		close = true,
		client = {
			image = 'advancedlockpick.png',
		},
	},

	['armor'] = {
		label = 'Armor',
		description = 'Some protection won\'t hurt... right?',
		category = 'tools',
		weight = 5000,
		stack = true,
		close = true,
		client = { image = 'armor.png' },
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		category = 'tools',
		weight = 3000,
		stack = false,
		client = {
			anim = { clip = 'try_shirt_positive_d', dict = 'clothingshirt' },
			usetime = 3500,
		},
	},

	['ashtray'] = {
		label = 'Ashtray',
		description = 'Glass ashtray.',
		category = 'tools',
		weight = 300,
		stack = true,
		close = true,
	},

	['attachment_bench'] = {
		label = 'Attachment Workbench',
		description = 'A workbench for crafting attachments.',
		category = 'tools',
		weight = 15000,
		stack = false,
		close = false,
	},

	['barber_changer'] = {
		label = 'Berber Wardrobe',
		description = '',
		category = 'tools',
		weight = 0,
		stack = true,
		close = false,
	},

	['barrier'] = {
		label = 'Barierka',
		category = 'tools',
		weight = 3,
		stack = true,
		close = true,
	},

	['binoculars'] = {
		label = 'Binoculars',
		description = 'Sneaky Breaky...',
		category = 'tools',
		weight = 600,
		stack = true,
		close = true,
		client = { image = 'binoculars.png' },
	},

	['blowpipe'] = {
		label = 'Blowtorch',
		category = 'tools',
		weight = 2,
		stack = true,
		close = true,
	},

	['bodycam'] = {
		label = 'Kamera nasobna',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	['bodycam_tablet'] = {
		label = 'Tablet kamer nasobnych',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	['broken_phone'] = {
		label = 'Zepsuty telefon',
		description = 'Zamókł i już się nie włącza',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
		client = { image = 'phone.png' },
	},

	['camera'] = {
		label = 'Aparat',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	['card'] = {
		label = 'Access Card',
		description = 'Cloned access card. Slide it through a door reader to bypass the lock — consumed on use.',
		category = 'tools',
		weight = 0,
		stack = true,
		close = false,
	},

	['cleaning_rag'] = {
		label = 'Cleaning Rag',
		description = 'Wipes a vehicle clean, tears eventually',
		category = 'tools',
		weight = 200,
		stack = true,
		close = true,
	},

	['clerk_tablet'] = {
		label = 'Tablet Urzędnika',
		description = 'Tablet do obsługi Urzędu Miasta',
		category = 'tools',
		weight = 10,
		stack = true,
		close = true,
		client = { image = 'clerk_tablet.png' },
	},

	['clothe_soap'] = {
		label = 'Soap',
		description = 'Soap for washing clothes.',
		category = 'tools',
		weight = 150,
		stack = true,
		close = true,
	},

	['cooler'] = {
		label = 'Portable Cooler',
		category = 'tools',
		weight = 2500,
		stack = false,
		close = false,
		consume = 0,
	},

	['diving_fill'] = {
		label = 'Diving Tube',
		description = 'An oxygen tube and a rebreather',
		category = 'tools',
		weight = 3000,
		stack = false,
		close = true,
	},

	['diving_gear'] = {
		label = 'Diving Gear',
		description = 'An oxygen tank and a rebreather',
		category = 'tools',
		weight = 30000,
		stack = false,
		close = true,
		client = { image = 'diving_gear.png' },
	},

	['drill'] = {
		label = 'Drill',
		description = 'The real deal...',
		category = 'tools',
		weight = 20000,
		stack = true,
		close = false,
		client = { image = 'drill.png' },
	},

	['drone'] = {
		label = 'Drone',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['duct_tape'] = {
		label = 'Duct Tape',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	['electronickit'] = {
		label = 'Electronic Kit',
		description = 'If you\'ve always wanted to build a robot you can maybe start here. Maybe you\'ll be the new Elon Musk?',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
		client = { image = 'electronickit.png' },
	},

	['empty_evidence_bag'] = {
		label = 'Empty Evidence Bag',
		description = 'Used a lot to keep DNA from blood, bullet shells and more',
		category = 'tools',
		weight = 0,
		stack = true,
		close = false,
	},

	['ems_radio'] = {
		label = 'EMS Radio',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['filled_evidence_bag'] = {
		label = 'Evidence Bag',
		description = 'A filled evidence bag to see who committed the crime >:(',
		category = 'tools',
		weight = 200,
		stack = false,
		close = false,
	},

	['firework1'] = {
		label = '2Brothers',
		description = 'Fireworks',
		category = 'tools',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'firework1.png' },
	},

	['firework2'] = {
		label = 'Poppelers',
		description = 'Fireworks',
		category = 'tools',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'firework2.png' },
	},

	['firework3'] = {
		label = 'WipeOut',
		description = 'Fireworks',
		category = 'tools',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'firework3.png' },
	},

	['firework4'] = {
		label = 'Weeping Willow',
		description = 'Fireworks',
		category = 'tools',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'firework4.png' },
	},

	['flat_tv'] = {
		label = 'Flat-screen TV',
		description = 'LED flat-screen television.',
		category = 'tools',
		weight = 6000,
		stack = true,
		close = true,
	},

	['gatecrack'] = {
		label = 'Gatecrack',
		description = 'Handy software to tear down some fences',
		category = 'tools',
		weight = 0,
		stack = true,
		close = true,
	},

	['glass_cutter'] = {
		label = 'Glass Cutter',
		description = 'For cutting jewellery display glass. Wears down on every use.',
		category = 'tools',
		weight = 400,
		stack = false,
		close = true,
	},

	['gps'] = {
		label = 'GPS',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = false,
		client = { image = 'gps.png' },
	},

	['gps_tracker'] = {
		label = 'Nadajnik GPS',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	['handcuffs'] = {
		label = 'Handcuffs',
		description = 'Comes in handy when people misbehave. Maybe it can be used for something else?',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
		client = { image = 'handcuffs.png' },
	},

	['handcuffs_key'] = {
		label = 'Kluczyk do kajdanek',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	['heavyarmor'] = {
		label = 'Heavy Armor',
		description = 'Some protection won\'t hurt... right?',
		category = 'tools',
		weight = 5000,
		stack = true,
		close = true,
	},

	['iphone'] = {
		label = 'iPhone',
		description = 'Very expensive phone',
		category = 'tools',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'iphone.png' },
	},

	['ironing_board'] = {
		label = 'Ironing Board',
		description = 'Old folding ironing board.',
		category = 'tools',
		weight = 3000,
		stack = true,
		close = true,
	},

	['item_bench'] = {
		label = 'Workbench',
		description = 'A workbench to craft items.',
		category = 'tools',
		weight = 15000,
		stack = false,
		close = false,
	},

	['kettle'] = {
		label = 'Kettle',
		description = 'Standard electric kettle.',
		category = 'tools',
		weight = 800,
		stack = true,
		close = true,
	},

	['labkey'] = {
		label = 'Key',
		description = 'Key for a lock...?',
		category = 'tools',
		weight = 500,
		stack = false,
		close = true,
		client = { image = 'labkey.png' },
	},

	['laptop'] = {
		label = 'Laptop',
		description = 'Expensive laptop',
		category = 'tools',
		weight = 4000,
		stack = true,
		close = true,
		client = { image = 'laptop.png' },
	},

	['light_remote'] = {
		label = 'Light Remote',
		description = 'Remote control for vehicle neon and xenon kits',
		category = 'tools',
		weight = 200,
		stack = true,
		close = true,
	},

	['lighter'] = {
		label = 'Lighter',
		description = 'On new years eve a nice fire to stand next to',
		category = 'tools',
		weight = 0,
		stack = true,
		close = true,
		client = { image = 'lighter.png' },
	},

	['lighting_controller'] = {
		label = 'Lighting Controller',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	['lockpick'] = {
		label = 'Lockpick',
		description = '',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		client = { image = 'lockpick.png' },
	},

	['megaphone'] = {
		label = 'megaphone',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['microphone'] = {
		label = 'microphone',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['microwave'] = {
		label = 'Microwave',
		description = 'Kitchen microwave oven.',
		category = 'tools',
		weight = 5000,
		stack = true,
		close = true,
	},

	['newsbmic'] = {
		label = 'Boom Microphone',
		description = 'A Useable BoomMic',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		client = { image = 'newsbmic.png' },
	},

	['newscam'] = {
		label = 'News Camera',
		description = 'A camera for the news',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		client = { image = 'newscam.png' },
	},

	['newsmic'] = {
		label = 'News Microphone',
		description = 'A microphone for the news',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		client = { image = 'newsmic.png' },
	},

	['old_phone'] = {
		label = 'Old Phone',
		description = 'Old-school landline phone.',
		category = 'tools',
		weight = 150,
		stack = true,
		close = true,
	},

	['old_tv'] = {
		label = 'Old TV',
		description = 'CRT television.',
		category = 'tools',
		weight = 8000,
		stack = true,
		close = true,
	},

	['panic_button'] = {
		label = 'Przycisk alarmowy',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	['paper_bag_rcore'] = {
		label = 'Worek na głowę',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	['paperbag'] = {
		label = 'Paper Bag',
		category = 'tools',
		weight = 1,
		stack = false,
		close = false,
		consume = 0,
	},

	['parachute'] = {
		label = 'Parachute',
		description = 'The sky is the limit! Woohoo!',
		category = 'tools',
		weight = 30000,
		stack = false,
		close = true,
		client = { image = 'parachute.png' },
	},

	['payment_terminal'] = {
		label = 'Terminal Płatniczy',
		description = 'Terminal do przyjmowania płatności kartą',
		category = 'tools',
		weight = 10,
		stack = true,
		close = true,
		client = {
			image = 'payment_terminal.png',
		},
	},

	['pd_gps'] = {
		label = 'PD GPS',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = false,
		client = { image = 'pd_gps.png' },
	},

	['pd_radio'] = {
		label = 'PD Radio',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['phone'] = {
		label = 'Telefon',
		description = 'Podstawowy telefon',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['pinger'] = {
		label = 'Pinger',
		description = 'With a pinger and your phone you can send out your location',
		category = 'tools',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'pinger.png' },
	},

	['pliers'] = {
		label = 'Szczypce medyczne',
		description = 'Used to treat taser prong wounds',
		category = 'tools',
		weight = 25,
		stack = false,
		close = true,
		client = { image = 'pliers.png' },
	},

	['polaroid'] = {
		label = 'Polaroid Image',
		description = '',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
	},

	['polaroid_empty'] = {
		label = 'Empty Polaroid',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = false,
	},

	['policedrone'] = {
		label = 'Police Drone',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['radio'] = {
		label = 'Radio',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['radioscanner'] = {
		label = 'Radio Scanner',
		description = 'With this you can get some police alerts. Not 100% effective however',
		category = 'tools',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'radioscanner.png' },
	},

	['robban_tablet'] = {
		label = 'Robban Tablet',
		description = 'A tablet that connects you to Robban.',
		category = 'tools',
		weight = 500,
		stack = true,
		close = true,
	},

	['samsungphone'] = {
		label = 'Samsung S10',
		description = 'Very expensive phone',
		category = 'tools',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'samsungphone.png' },
	},

	['screwdriverset'] = {
		label = 'Toolkit',
		description = 'Very useful to screw... screws...',
		category = 'tools',
		weight = 1000,
		stack = true,
		close = false,
		client = {
			image = 'screwdriverset.png',
		},
	},

	['sim'] = {
		label = 'sim',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['soap'] = {
		label = 'Soap',
		description = 'Luxury brand soap.',
		category = 'tools',
		weight = 150,
		stack = true,
		close = true,
	},

	['speed_camera'] = {
		label = 'Fotoradar przenośny',
		category = 'tools',
		weight = 3,
		stack = true,
		close = true,
	},

	['spikes'] = {
		label = 'Kolczatka',
		category = 'tools',
		weight = 3,
		stack = true,
		close = true,
	},

	['spiketrap'] = {
		label = 'Spike Trap',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['t_armor_heavy'] = {
		label = 'Heavy Armor',
		description = '',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
	},

	['t_armor_light'] = {
		label = 'Light Armor',
		description = '',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
	},

	['t_armor_plate_heavy'] = {
		label = 'Heavy Armor Plate',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['t_armor_plate_light'] = {
		label = 'Light Armor Plate',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['t_handcuffs'] = {
		label = 'Handcuffs',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['t_handcuffs_key'] = {
		label = 'Handcuffs Key',
		description = '',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
	},

	['t_police_handcuffs'] = {
		label = 'Police Handcuffs',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['t_police_handcuffs_key'] = {
		label = 'Police Handcuffs Key',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['tablet'] = {
		label = 'Tablet',
		description = 'Expensive tablet',
		category = 'tools',
		weight = 2000,
		stack = true,
		close = true,
		client = { image = 'tablet.png' },
	},

	['tattoo_ink'] = {
		label = 'Tattoo Ink',
		category = 'tools',
		weight = 10,
		stack = true,
		close = true,
	},

	['tattoo_laser'] = {
		label = 'Tattoo Laser',
		category = 'tools',
		weight = 10,
		stack = true,
		close = true,
	},

	['tattoo_machine'] = {
		label = 'Tattoo Machine',
		category = 'tools',
		weight = 10,
		stack = true,
		close = true,
	},

	['television'] = {
		label = 'Television',
		description = '',
		category = 'tools',
		weight = 100,
		stack = true,
		close = true,
	},

	['thermite'] = {
		label = 'Thermite',
		description = 'Sometimes you\'d wish for everything to burn',
		category = 'tools',
		weight = 1000,
		stack = true,
		close = true,
		client = { image = 'thermite.png' },
	},

	['toaster'] = {
		label = 'Toaster',
		description = 'Two-slice toaster.',
		category = 'tools',
		weight = 2000,
		stack = true,
		close = true,
	},

	['tools'] = {
		label = 'Tools',
		description = 'Screwdriver, hammer and a few small tools.',
		category = 'tools',
		weight = 1500,
		stack = true,
		close = true,
	},

	['towel'] = {
		label = 'Towel',
		description = 'Soft bath towel.',
		category = 'tools',
		weight = 400,
		stack = true,
		close = true,
	},

	['trojan_usb'] = {
		label = 'Trojan USB',
		description = 'Handy software to shut down some systems',
		category = 'tools',
		weight = 0,
		stack = true,
		close = true,
	},

	['y24_black'] = {
		label = 'Y24 Black',
		description = 'Smartfon Y24',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['y24_silver'] = {
		label = 'Y24 Silver',
		description = 'Smartfon Y24',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['y24_violet'] = {
		label = 'Y24 Violet',
		description = 'Smartfon Y24',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['y24_yellow'] = {
		label = 'Y24 Yellow',
		description = 'Smartfon Y24',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['yboomer_black'] = {
		label = 'Boomer Phone',
		description = 'Klasyczny telefon z klawiaturą',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'yboomer_black.png',
			export = 'yboomer-phone.UsePhoneItem',
		},
	},

	['yflip_gold'] = {
		label = 'YFlip Gold',
		description = 'Telefon typu klapka YFlip',
		category = 'tools',
		weight = 90,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['yflip_graphite'] = {
		label = 'YFlip Graphite',
		description = 'Telefon typu klapka YFlip',
		category = 'tools',
		weight = 90,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['yflip_lavender'] = {
		label = 'YFlip Lavender',
		description = 'Telefon typu klapka YFlip',
		category = 'tools',
		weight = 90,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['yflip_mint'] = {
		label = 'YFlip Mint',
		description = 'Telefon typu klapka YFlip',
		category = 'tools',
		weight = 90,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['yfold_black'] = {
		label = 'YFold Black',
		description = 'Składany smartfon YFold',
		category = 'tools',
		weight = 120,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['yphone_black'] = {
		label = 'YPhone Black',
		description = 'Smartfon YPhone',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['yphone_blue'] = {
		label = 'YPhone Blue',
		description = 'Smartfon YPhone',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['yphone_fold_black'] = {
		label = 'YPhone Fold Black',
		description = 'Składany smartfon YPhone Fold',
		category = 'tools',
		weight = 120,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['yphone_natural'] = {
		label = 'YPhone Natural',
		description = 'Smartfon YPhone',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['yphone_white'] = {
		label = 'YPhone White',
		description = 'Smartfon YPhone',
		category = 'tools',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			image = 'phone.png',
			export = 'yseries.UsePhoneItem',
		},
	},

	['ys_sim_card'] = {
		label = 'Karta SIM',
		description = 'Karta SIM do telefonu',
		category = 'tools',
		weight = 5,
		stack = false,
		close = false,
		client = { image = 'bank_card.png' },
	},

	['zipties'] = {
		label = 'Opaski zaciskowe',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	['zipties_cutter'] = {
		label = 'Obcinak do opasek',
		category = 'tools',
		weight = 1,
		stack = true,
		close = true,
	},

	-- Documents and cards (33)
	['bank_card'] = {
		label = 'Bank Card',
		description = 'Used to access ATM',
		category = 'documents',
		weight = 0,
		stack = false,
		close = true,
		client = { image = 'bank_card.png' },
	},

	['certificate'] = {
		label = 'Certificate',
		description = 'Certificate that proves you own certain stuff',
		category = 'documents',
		weight = 0,
		stack = true,
		close = true,
		client = { image = 'certificate.png' },
	},

	['creditcard_lvl_1'] = {
		label = 'Lost Credit Cards Normal',
		description = '',
		category = 'documents',
		weight = 100,
		stack = true,
		close = true,
	},

	['creditcard_lvl_2'] = {
		label = 'Lost Credit Cards Gold',
		description = '',
		category = 'documents',
		weight = 100,
		stack = true,
		close = true,
	},

	['creditcard_lvl_3'] = {
		label = 'Lost Credit Cards Platinum',
		description = '',
		category = 'documents',
		weight = 100,
		stack = true,
		close = true,
	},

	['debitcard_business'] = {
		label = 'Karta Debetowa Firmowa',
		description = 'Firmowa karta bankowa do wyplat w bankomatach',
		category = 'documents',
		weight = 10,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'tgg-banking.UseCardOnAtm',
			image = 'debitcard_business.png',
		},
	},

	['debitcard_personal'] = {
		label = 'Karta Debetowa Osobista',
		description = 'Karta bankowa do wyplat w bankomatach',
		category = 'documents',
		weight = 10,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'tgg-banking.UseCardOnAtm',
			image = 'debitcard_personal.png',
		},
	},

	['debitcard_shared'] = {
		label = 'Karta Debetowa Wspolna',
		description = 'Wspolna karta bankowa do wyplat w bankomatach',
		category = 'documents',
		weight = 10,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'tgg-banking.UseCardOnAtm',
			image = 'debitcard_shared.png',
		},
	},

	['documents'] = {
		label = 'Documents',
		description = 'Confidential business documents.',
		category = 'documents',
		weight = 200,
		stack = true,
		close = true,
	},

	['driver_license'] = {
		label = 'Drivers License',
		description = 'Permit to show you can drive a vehicle',
		category = 'documents',
		weight = 0,
		stack = false,
		close = false,
		client = {
			image = 'driver_license.png',
		},
	},

	['dyno_report'] = {
		label = 'Dyno Report',
		description = 'Printed dyno test report',
		category = 'documents',
		weight = 50,
		stack = false,
		close = true,
	},

	['empty_invoice'] = {
		label = 'Pusta Faktura',
		description = 'Pusty formularz faktury',
		category = 'documents',
		weight = 3,
		stack = true,
		close = true,
		client = { image = 'empty_invoice.png' },
	},

	['empty_ticket'] = {
		label = 'Pusty Mandat',
		description = 'Pusty formularz mandatu',
		category = 'documents',
		weight = 2,
		stack = true,
		close = true,
		client = { image = 'empty_ticket.png' },
	},

	['id_card'] = {
		label = 'ID Card',
		description = 'A card containing all your information to identify yourself',
		category = 'documents',
		weight = 0,
		stack = false,
		close = false,
		client = { image = 'id_card.png' },
	},

	['identification'] = {
		label = 'Identification',
		category = 'documents',
		client = { image = 'card_id.png' },
	},

	['invoice'] = {
		label = 'Faktura',
		description = 'Wystawiona faktura',
		category = 'documents',
		weight = 4,
		stack = false,
		close = true,
		client = { image = 'invoice.png' },
	},

	['lawyerpass'] = {
		label = 'Lawyer Pass',
		description = 'Pass exclusive to lawyers to show they can represent a suspect',
		category = 'documents',
		weight = 0,
		stack = false,
		close = false,
		client = { image = 'lawyerpass.png' },
	},

	['magazine'] = {
		label = 'Magazine',
		description = 'Monthly magazine.',
		category = 'documents',
		weight = 200,
		stack = true,
		close = true,
	},

	['mastercard'] = {
		label = 'Fleeca Card',
		category = 'documents',
		weight = 10,
		stack = false,
		client = { image = 'card_bank.png' },
	},

	['photo'] = {
		label = 'Zdjęcie',
		category = 'documents',
		weight = 1,
		stack = true,
		close = true,
	},

	['postcard'] = {
		label = 'Postcard',
		description = 'A postcard you can send to someone.',
		category = 'documents',
		weight = 50,
		stack = true,
		close = true,
	},

	['printerdocument'] = {
		label = 'Document',
		description = 'A nice document',
		category = 'documents',
		weight = 500,
		stack = false,
		close = true,
		client = {
			image = 'printerdocument.png',
		},
	},

	['receipt'] = {
		label = 'Paragon',
		description = 'Wystawiony paragon',
		category = 'documents',
		weight = 1,
		stack = false,
		close = true,
		client = { image = 'receipt.png' },
	},

	['rental_document'] = {
		label = 'Rental Document',
		description = 'A document that proves you rented a vehicle',
		category = 'documents',
		weight = 200,
		stack = false,
		close = true,
	},

	['security_card_01'] = {
		label = 'Security Card A',
		description = 'A security card... I wonder what it goes to',
		category = 'documents',
		weight = 0,
		stack = true,
		close = true,
		client = {
			image = 'security_card_01.png',
		},
	},

	['security_card_02'] = {
		label = 'Security Card B',
		description = 'A security card... I wonder what it goes to',
		category = 'documents',
		weight = 0,
		stack = true,
		close = true,
		client = {
			image = 'security_card_02.png',
		},
	},

	['signed_vehicle_sale_agreement'] = {
		label = 'Podpisana Umowa Sprzedaży',
		description = 'Podpisana umowa kupna-sprzedaży pojazdu',
		category = 'documents',
		weight = 5,
		stack = false,
		close = true,
		client = {
			image = 'signed_vehicle_sale_agreement.png',
		},
	},

	['stickynote'] = {
		label = 'Sticky note',
		description = 'Sometimes handy to remember something :)',
		category = 'documents',
		weight = 0,
		stack = false,
		close = false,
		client = { image = 'stickynote.png' },
	},

	['testlicense'] = {
		label = 'Test License',
		description = 'testlicense',
		category = 'documents',
		weight = 0,
		stack = true,
		close = true,
	},

	['thermal_paper'] = {
		label = 'Papier Termiczny',
		description = 'Papier do drukowania paragonów',
		category = 'documents',
		weight = 1,
		stack = true,
		close = false,
		client = { image = 'thermal_paper.png' },
	},

	['ticket'] = {
		label = 'Mandat',
		description = 'Wystawiony mandat',
		category = 'documents',
		weight = 3,
		stack = false,
		close = true,
		client = { image = 'ticket.png' },
	},

	['vehicle_sale_agreement'] = {
		label = 'Umowa Sprzedaży',
		description = 'Pusta umowa kupna-sprzedaży pojazdu',
		category = 'documents',
		weight = 4,
		stack = true,
		close = true,
		client = {
			image = 'vehicle_sale_agreement.png',
		},
	},

	['weaponlicense'] = {
		label = 'Weapon License',
		description = 'Weapon License',
		category = 'documents',
		weight = 0,
		stack = false,
		close = true,
	},

	-- Valuables and money (35)
	['antipatharia_coral'] = {
		label = 'Antipatharia',
		description = 'Its also known as black corals or thorn corals',
		category = 'valuables',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			image = 'antipatharia_coral.png',
		},
	},

	['black_money'] = {
		label = 'Dirty Money',
		description = 'Untraceable cash. The heist hands out a random amount per drop.',
		category = 'valuables',
		weight = 0,
		stack = true,
		close = true,
		client = { image = 'black_money.png' },
	},

	['bouquet'] = {
		label = 'Bukiet kwiatów',
		description = 'Bukiet kwiatów do trzymania lub wręczenia',
		category = 'valuables',
		weight = 500,
		stack = true,
		close = true,
		consume = 0,
		client = { usetime = 2500 },
	},

	['casinochips'] = {
		label = 'Casino Chips',
		description = 'Chips For Casino Gambling',
		category = 'valuables',
		weight = 0,
		stack = true,
		close = false,
		client = { image = 'casinochips.png' },
	},

	['cheap_ring'] = {
		label = 'Cheap Ring',
		description = 'Copper-plated cheap ring.',
		category = 'valuables',
		weight = 50,
		stack = true,
		close = true,
	},

	['cryptostick'] = {
		label = 'Crypto Stick',
		description = 'Why would someone ever buy money that doesn\'t exist.. How many would it contain..?',
		category = 'valuables',
		weight = 200,
		stack = false,
		close = true,
		client = { image = 'cryptostick.png' },
	},

	['decorative_head'] = {
		label = 'Decorative Head',
		description = 'Artistic face sculpture.',
		category = 'valuables',
		weight = 1500,
		stack = true,
		close = true,
	},

	['dendrogyra_coral'] = {
		label = 'Dendrogyra',
		description = 'Its also known as pillar coral',
		category = 'valuables',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			image = 'dendrogyra_coral.png',
		},
	},

	['diamond'] = {
		label = 'Diamond',
		description = 'A diamond seems like the jackpot to me!',
		category = 'valuables',
		weight = 1000,
		stack = true,
		close = true,
	},

	['diamond_ring'] = {
		label = 'Diamond Ring',
		description = 'A diamond ring seems like the jackpot to me!',
		category = 'valuables',
		weight = 1500,
		stack = true,
		close = true,
		client = { image = 'diamond_ring.png' },
	},

	['fitbit'] = {
		label = 'Fitbit',
		description = 'I like fitbit',
		category = 'valuables',
		weight = 500,
		stack = false,
		close = true,
		client = { image = 'fitbit.png' },
	},

	['flamenco_figurine'] = {
		label = 'Flamenco Dancer',
		description = 'Porcelain flamenco dancer figurine.',
		category = 'valuables',
		weight = 800,
		stack = true,
		close = true,
	},

	['gold'] = {
		label = 'Gold',
		category = 'valuables',
		weight = 1,
		stack = true,
		close = true,
	},

	['gold_bar'] = {
		label = 'Gold Bar',
		description = '1 kg pure gold bar.',
		category = 'valuables',
		weight = 1000,
		stack = true,
		close = true,
	},

	['gold_chain'] = {
		label = 'Gold Chain',
		description = 'Solid gold chain.',
		category = 'valuables',
		weight = 150,
		stack = true,
		close = true,
	},

	['gold_ring'] = {
		label = 'Gold Ring',
		description = 'Solid gold ring.',
		category = 'valuables',
		weight = 80,
		stack = true,
		close = true,
	},

	['goldbar'] = {
		label = 'Gold Bar',
		description = 'Looks pretty expensive to me',
		category = 'valuables',
		weight = 7000,
		stack = true,
		close = true,
		client = { image = 'goldbar.png' },
	},

	['goldchain'] = {
		label = 'Golden Chain',
		description = 'A golden chain seems like the jackpot to me!',
		category = 'valuables',
		weight = 1500,
		stack = true,
		close = true,
		client = { image = 'goldchain.png' },
	},

	['markedbills'] = {
		label = 'Marked Money',
		description = 'Money?',
		category = 'valuables',
		weight = 1000,
		stack = false,
		close = true,
		client = { image = 'markedbills.png' },
	},

	['money'] = {
		label = 'Gotówka',
		category = 'valuables',
		weight = 0,
		stack = true,
		close = false,
		client = { image = 'money.png' },
	},

	['moneybag'] = {
		label = 'Money Bag',
		description = 'A bag with cash',
		category = 'valuables',
		weight = 0,
		stack = false,
		close = true,
		client = { image = 'moneybag.png' },
	},

	['obelisk_figurine'] = {
		label = 'Obelisk Figurine',
		description = 'Egyptian-themed obelisk trinket.',
		category = 'valuables',
		weight = 800,
		stack = true,
		close = true,
	},

	['painting_canvas'] = {
		label = 'Painting Canvas',
		description = 'Canvas cut from a frame. Sells on the black market.',
		category = 'valuables',
		weight = 1500,
		stack = true,
		close = true,
	},

	['painting_oilcanvas'] = {
		label = 'Oil Canvas Painting',
		description = 'Antique oil painting. Sells to collectors.',
		category = 'valuables',
		weight = 2000,
		stack = true,
		close = true,
	},

	['perfume'] = {
		label = 'Perfume',
		description = 'Designer perfume bottle.',
		category = 'valuables',
		weight = 300,
		stack = true,
		close = true,
	},

	['present'] = {
		label = 'Present',
		description = '',
		category = 'valuables',
		weight = 100,
		stack = true,
		close = true,
	},

	['rare_diamond'] = {
		label = 'Rare Diamond',
		description = 'Rare diamond stolen from a display case.',
		category = 'valuables',
		weight = 50,
		stack = true,
		close = true,
	},

	['rolex'] = {
		label = 'Golden Watch',
		description = 'A golden watch seems like the jackpot to me!',
		category = 'valuables',
		weight = 1500,
		stack = true,
		close = true,
		client = { image = 'rolex.png' },
	},

	['rose'] = {
		label = 'Róża',
		description = 'Pojedyncza róża do trzymania lub wręczenia',
		category = 'valuables',
		weight = 50,
		stack = true,
		close = true,
		consume = 0,
		client = { usetime = 2500 },
	},

	['sculpture_small'] = {
		label = 'Small Sculpture',
		description = 'Small artistic sculpture.',
		category = 'valuables',
		weight = 1500,
		stack = true,
		close = true,
	},

	['silver_chain'] = {
		label = 'Silver Chain',
		description = 'Pure silver chain.',
		category = 'valuables',
		weight = 100,
		stack = true,
		close = true,
	},

	['tenkgoldchain'] = {
		label = '10k Gold Chain',
		description = '10 carat golden chain',
		category = 'valuables',
		weight = 2000,
		stack = true,
		close = true,
	},

	['wallet'] = {
		label = 'Wallet',
		description = 'Leather wallet with a few cards and loose change.',
		category = 'valuables',
		weight = 150,
		stack = true,
		close = true,
	},

	['wristwatch'] = {
		label = 'Wristwatch',
		description = 'Wristwatch in good condition.',
		category = 'valuables',
		weight = 150,
		stack = true,
		close = true,
	},

	['wristwatch_old'] = {
		label = 'Old Wristwatch',
		description = 'Worn-out quartz watch.',
		category = 'valuables',
		weight = 100,
		stack = true,
		close = true,
	},

	-- Materials (22)
	['aluminum'] = {
		label = 'Aluminum',
		description = 'Aluminum material',
		category = 'materials',
		weight = 300,
		stack = true,
		close = true,
		client = { image = 'aluminum.png' },
	},

	['aluminumoxide'] = {
		label = 'Aluminium Powder',
		description = 'Some powder to mix with',
		category = 'materials',
		weight = 100,
		stack = true,
		close = false,
		client = { image = 'aluminumoxide.png' },
	},

	['cloth'] = {
		label = 'Cloth',
		description = 'Piece of cloth',
		category = 'materials',
		weight = 150,
		stack = true,
		close = false,
	},

	['clothe'] = {
		label = 'Cloth',
		category = 'materials',
		weight = 1,
		stack = true,
		close = true,
	},

	['copper'] = {
		label = 'Copper',
		description = 'Nice piece of metal that you can probably use for something',
		category = 'materials',
		weight = 100,
		stack = true,
		close = false,
		client = { image = 'copper.png' },
	},

	['cutted_wood'] = {
		label = 'Cut wood',
		category = 'materials',
		weight = 1,
		stack = true,
		close = true,
	},

	['fabric'] = {
		label = 'Fabric',
		category = 'materials',
		weight = 1,
		stack = true,
		close = true,
	},

	['fabric_scrap'] = {
		label = 'Fabric Scrap',
		description = 'Scrap piece of fabric',
		category = 'materials',
		weight = 100,
		stack = true,
		close = false,
	},

	['glass'] = {
		label = 'Glass',
		description = 'It is very fragile, watch out',
		category = 'materials',
		weight = 100,
		stack = true,
		close = false,
		client = { image = 'glass.png' },
	},

	['iron'] = {
		label = 'Iron',
		description = 'Steam iron.',
		category = 'materials',
		weight = 1200,
		stack = true,
		close = true,
		client = { image = 'iron.png' },
	},

	['iron_ingot'] = {
		label = 'Iron Ingot',
		description = 'Iron ingot',
		category = 'materials',
		weight = 1000,
		stack = true,
		close = true,
	},

	['ironoxide'] = {
		label = 'Iron Powder',
		description = 'Some powder to mix with.',
		category = 'materials',
		weight = 100,
		stack = true,
		close = false,
		client = { image = 'ironoxide.png' },
	},

	['metalscrap'] = {
		label = 'Metal Scrap',
		description = 'You can probably make something nice out of this',
		category = 'materials',
		weight = 100,
		stack = true,
		close = false,
		client = { image = 'metalscrap.png' },
	},

	['packaged_plank'] = {
		label = 'Packaged wood',
		category = 'materials',
		weight = 1,
		stack = true,
		close = true,
	},

	['plastic'] = {
		label = 'Plastic',
		description = 'Plastic material',
		category = 'materials',
		weight = 200,
		stack = true,
		close = true,
		client = { image = 'plastic.png' },
	},

	['rubber'] = {
		label = 'Rubber',
		description = 'Rubber, I believe you can make your own rubber ducky with it :D',
		category = 'materials',
		weight = 100,
		stack = true,
		close = false,
		client = { image = 'rubber.png' },
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		category = 'materials',
		weight = 80,
	},

	['steel'] = {
		label = 'Steel',
		description = 'Nice piece of metal that you can probably use for something',
		category = 'materials',
		weight = 100,
		stack = true,
		close = false,
		client = { image = 'steel.png' },
	},

	['stone'] = {
		label = 'Stone',
		category = 'materials',
		weight = 1,
		stack = true,
		close = true,
	},

	['washed_stone'] = {
		label = 'Washed stone',
		category = 'materials',
		weight = 1,
		stack = true,
		close = true,
	},

	['wood'] = {
		label = 'Wood',
		category = 'materials',
		weight = 1,
		stack = true,
		close = true,
	},

	['wool'] = {
		label = 'Wool',
		category = 'materials',
		weight = 1,
		stack = true,
		close = true,
	},

	-- Clothing (33)
	['bag'] = {
		label = 'Bag',
		description = 'Bag to store items',
		category = 'clothing',
		weight = 500,
		stack = true,
		close = true,
	},

	['bkposet'] = {
		label = 'Clothes Bag Plus',
		description = 'Special Bag to Store Your Clothes',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = false,
	},

	['c_bag'] = {
		label = 'Bag (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_bproof'] = {
		label = 'Bullet Proof (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_bracelet'] = {
		label = 'Bracelet (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_decal'] = {
		label = 'Decals (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_ear'] = {
		label = 'Ear (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_glasses'] = {
		label = 'Glasses (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_helmet'] = {
		label = 'Hat (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_mask'] = {
		label = 'Mask (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_necklace'] = {
		label = 'Necklace (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_pants'] = {
		label = 'Pants (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_shoes'] = {
		label = 'Shoes (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_torso'] = {
		label = 'Torso (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['c_watch'] = {
		label = 'Watch (Clothe)',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['clothe_set'] = {
		label = 'Clothe Set',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ms_inventory.useClothing' },
	},

	['clothes'] = {
		label = 'Clothes',
		description = 'Bundle of branded clothing.',
		category = 'clothing',
		weight = 600,
		stack = true,
		close = true,
	},

	['clothing'] = {
		label = 'Clothing',
		category = 'clothing',
		consume = 0,
	},

	['clothing_accessory'] = {
		label = 'Accessory',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_bag'] = {
		label = 'Bag',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_bracelet'] = {
		label = 'Bracelet',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_changer'] = {
		label = 'Clothe Wardrobe',
		description = '',
		category = 'clothing',
		weight = 0,
		stack = true,
		close = false,
	},

	['clothing_ears'] = {
		label = 'Earrings',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_glasses'] = {
		label = 'Glasses',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_hat'] = {
		label = 'Hat',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_mask'] = {
		label = 'Mask',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_pants'] = {
		label = 'Pants',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_shoes'] = {
		label = 'Shoes',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_top'] = {
		label = 'Top',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_vest'] = {
		label = 'Vest',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['clothing_watch'] = {
		label = 'Watch',
		category = 'clothing',
		weight = 300,
		stack = false,
		close = true,
		consume = 0,
		client = { export = 'ox_inventory.wearClothing' },
	},

	['headbag'] = {
		label = 'Headbag',
		description = '',
		category = 'clothing',
		weight = 100,
		stack = true,
		close = true,
	},

	['kposet'] = {
		label = 'Clothes Bag',
		description = 'Special Bag to Store Your Clothes',
		category = 'clothing',
		weight = 100,
		stack = false,
		close = false,
	},

	-- Other (7)
	['condom'] = {
		label = 'Prezerwatywa',
		description = 'Otwiera się z krótką animacją',
		category = 'other',
		weight = 20,
		stack = true,
		close = true,
		consume = 1,
		client = {
			anim = {
				clip = 'idle_a',
				dict = 'missheistdockssetup1clipboard@idle_a',
				flag = 49,
			},
			usetime = 3000,
		},
	},

	['garbage'] = {
		label = 'Garbage',
		category = 'other',
	},

	['lang_item'] = {
		label = { en = 'Example Multi Language Label', tr = 'Örnek Çok Dilli Etiket' },
		description = {
			en = 'This is an item with an example multi language label.',
			tr = 'Bu bir örnek çok dilli etiket içeren bir öğedir.',
		},
		category = 'other',
		weight = 100,
		stack = true,
		close = true,
	},

	['panties'] = {
		label = 'Knickers',
		category = 'other',
		weight = 10,
		consume = 0,
		client = {
			status = { stress = -25000, thirst = -100000 },
			anim = { clip = 'loop_bottle', dict = 'mp_player_intdrink' },
			prop = {
				model = 392343608,
				pos = vec3(0.03, 0.0, 0.02),
				rot = vec3(0.0, -13.5, -1.5),
			},
			usetime = 2500,
		},
	},

	['testitem'] = {
		label = 'Test Item',
		description = 'testitem',
		category = 'other',
		weight = 0,
		stack = true,
		close = true,
		consume = 0,
		client = {
			anim = {
				clip = 'idle_a',
				dict = 'missheistdockssetup1clipboard@idle_a',
				flag = 49,
			},
			usetime = 3000,
		},
	},

	['testitemlong'] = {
		label = 'Test Item Long Long Long Name',
		description = 'testitemlong',
		category = 'other',
		weight = 0,
		stack = true,
		close = true,
	},

	['testitemuniq'] = {
		label = 'Test Item Uniq',
		description = 'testitemuniq',
		category = 'other',
		weight = 10,
		stack = true,
		close = true,
	},
}
