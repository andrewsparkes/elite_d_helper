# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	# Commodity Types
	CommodityType.delete_all
  	ct_chemicals            = CommodityType.create!([{ name: 'Chemicals', order_num: 10 }]).first
	ct_consumer_items       = CommodityType.create!([{ name: 'Consumer Items', order_num: 20 }]).first
	ct_foods                = CommodityType.create!([{ name: 'Foods', order_num: 30 }]).first
	ct_industrial_materials = CommodityType.create!([{ name: 'Industrial Materials', order_num: 40 }]).first
	ct_legal_drugs          = CommodityType.create!([{ name: 'Legal Drugs', order_num: 50 }]).first
	ct_machinery            = CommodityType.create!([{ name: 'Machinery', order_num: 60 }]).first
	ct_medicines            = CommodityType.create!([{ name: 'Medicines', order_num: 70 }]).first
	ct_metals               = CommodityType.create!([{ name: 'Metals', order_num: 80 }]).first
	ct_minerals             = CommodityType.create!([{ name: 'Minerals', order_num: 90 }]).first
	ct_technology           = CommodityType.create!([{ name: 'Technology', order_num: 100 }]).first
	ct_textiles             = CommodityType.create!([{ name: 'Textiles', order_num: 110 }]).first
	ct_waste                = CommodityType.create!([{ name: 'Waste', order_num: 120 }]).first
	ct_weapons              = CommodityType.create!([{ name: 'Weapons', order_num: 130 }]).first

  	# Commodities
  	Commodity.delete_all
  	c_explosives = Commodity.create!([{ commodity_type_id: ct_chemicals.id, name: 'Explosives', galactic_average_price: 280 }]).first
  	c_hyd_fuel   = Commodity.create!([{ commodity_type_id: ct_chemicals.id, name: 'Hydrogen Fuel', galactic_average_price: 116 }]).first
  	c_min_oil    = Commodity.create!([{ commodity_type_id: ct_chemicals.id, name: 'Mineral Oil', galactic_average_price: 172 }]).first
  	c_pesticides = Commodity.create!([{ commodity_type_id: ct_chemicals.id, name: 'Pesticides', galactic_average_price: 286 }]).first

	c_clothing   = Commodity.create!([{ commodity_type_id: ct_consumer_items.id, name: 'Clothing', galactic_average_price: 287 }]).first
	c_cons_tech  = Commodity.create!([{ commodity_type_id: ct_consumer_items.id, name: 'Consumer Technology', galactic_average_price: 6697 }]).first
	c_dom_appl   = Commodity.create!([{ commodity_type_id: ct_consumer_items.id, name: 'Domestic Appliances', galactic_average_price: 495 }]).first

	c_algae      = Commodity.create!([{ commodity_type_id: ct_foods.id, name: 'Algae', galactic_average_price: 193 }]).first
	c_anim_meat  = Commodity.create!([{ commodity_type_id: ct_foods.id, name: 'Animal Meat', galactic_average_price: 1269 }]).first
	c_coffee     = Commodity.create!([{ commodity_type_id: ct_foods.id, name: 'Coffee', galactic_average_price: 1258 }]).first
	c_fish       = Commodity.create!([{ commodity_type_id: ct_foods.id, name: 'Fish', galactic_average_price: 382 }]).first
	c_food_cart  = Commodity.create!([{ commodity_type_id: ct_foods.id, name: 'Food Cartridges', galactic_average_price: 112 }]).first
	c_fruit      = Commodity.create!([{ commodity_type_id: ct_foods.id, name: 'Fruit and Vegetables', galactic_average_price: 289 }]).first
	c_grain      = Commodity.create!([{ commodity_type_id: ct_foods.id, name: 'Grain', galactic_average_price: 183 }]).first
	c_synth_meat = Commodity.create!([{ commodity_type_id: ct_foods.id, name: 'Synthetic Meat', galactic_average_price: 240 }]).first
	c_tea        = Commodity.create!([{ commodity_type_id: ct_foods.id, name: 'Tea', galactic_average_price: 1443 }]).first

	c_polymers   = Commodity.create!([{ commodity_type_id: ct_industrial_materials.id, name: 'Polymers', galactic_average_price: 137 }]).first
	c_semicond   = Commodity.create!([{ commodity_type_id: ct_industrial_materials.id, name: 'Semiconductors', galactic_average_price: 893 }]).first
	c_supercond  = Commodity.create!([{ commodity_type_id: ct_industrial_materials.id, name: 'Superconductors', galactic_average_price: 6669 }]).first

	c_beer       = Commodity.create!([{ commodity_type_id: ct_legal_drugs.id, name: 'Beer', galactic_average_price: 154 }]).first
	c_liquor     = Commodity.create!([{ commodity_type_id: ct_legal_drugs.id, name: 'Liquor', galactic_average_price: 615 }]).first
	c_tobacco    = Commodity.create!([{ commodity_type_id: ct_legal_drugs.id, name: 'Tobacco', galactic_average_price: 5082 }]).first
	c_wine       = Commodity.create!([{ commodity_type_id: ct_legal_drugs.id, name: 'Wine', galactic_average_price: 233 }]).first

	c_atmos_proc = Commodity.create!([{ commodity_type_id: ct_machinery.id, name: 'Atmospheric Processors', galactic_average_price: 369 }]).first
	c_crop_harv  = Commodity.create!([{ commodity_type_id: ct_machinery.id, name: 'Crop Harvesters', galactic_average_price: 2372 }]).first
	c_marine_eq  = Commodity.create!([{ commodity_type_id: ct_machinery.id, name: 'Marine Equipment', galactic_average_price: 4062 }]).first
	c_microb_fur = Commodity.create!([{ commodity_type_id: ct_machinery.id, name: 'Microbial Furnaces', galactic_average_price: 188 }]).first
	c_min_extrct = Commodity.create!([{ commodity_type_id: ct_machinery.id, name: 'Mineral Extractors', galactic_average_price: 550 }]).first
	c_power_gen  = Commodity.create!([{ commodity_type_id: ct_machinery.id, name: 'Power Generators', galactic_average_price: 488 }]).first
	c_water_pur  = Commodity.create!([{ commodity_type_id: ct_machinery.id, name: 'Water Purifiers', galactic_average_price: 269 }]).first

	c_agrichem   = Commodity.create!([{ commodity_type_id: ct_medicines.id, name: 'Agrichemicals', galactic_average_price: 286 }]).first
	c_agric_meds = Commodity.create!([{ commodity_type_id: ct_medicines.id, name: 'Agri-Medicines', galactic_average_price: 996 }]).first
	c_basic_meds = Commodity.create!([{ commodity_type_id: ct_medicines.id, name: 'Basic Medicines', galactic_average_price: 286 }]).first
	c_perf_enh   = Commodity.create!([{ commodity_type_id: ct_medicines.id, name: 'Performance Enhancers', galactic_average_price: 6678 }]).first
	c_prog_cells = Commodity.create!([{ commodity_type_id: ct_medicines.id, name: 'Progenitor Cells', galactic_average_price: 6698 }]).first

	c_aluminium  = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Aluminium', galactic_average_price: 313 }]).first
	c_beryllium  = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Beryllium', galactic_average_price: 8192 }]).first
	c_cobalt     = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Cobalt', galactic_average_price: 665 }]).first
	c_copper     = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Copper', galactic_average_price: 449 }]).first
	c_gallium    = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Gallium', galactic_average_price: 5126 }]).first
	c_gold       = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Gold', galactic_average_price: 9379 }]).first
	c_indium     = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Indium', galactic_average_price: 5815 }]).first
	c_lithium    = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Lithium', galactic_average_price: 1557 }]).first
	c_palladium  = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Palladium', galactic_average_price: 13252 }]).first
	c_platinum   = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Platinum', galactic_average_price: 18893 }]).first
	c_silver     = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Silver', galactic_average_price: 4769 }]).first
	c_tantalum   = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Tantalum', galactic_average_price: 3914 }]).first
	c_titanium   = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Titanium', galactic_average_price: 980 }]).first
	c_uranium    = Commodity.create!([{ commodity_type_id: ct_metals.id, name: 'Uranium', galactic_average_price: 2636 }]).first

	c_bauxite    = Commodity.create!([{ commodity_type_id: ct_minerals.id, name: 'Bauxite', galactic_average_price: 122 }]).first
	c_bertrand   = Commodity.create!([{ commodity_type_id: ct_minerals.id, name: 'Bertrandite', galactic_average_price: 2409 }]).first
	c_coltan     = Commodity.create!([{ commodity_type_id: ct_minerals.id, name: 'Coltan', galactic_average_price: 1341 }]).first
	c_gallite    = Commodity.create!([{ commodity_type_id: ct_minerals.id, name: 'Gallite', galactic_average_price: 1854 }]).first
	c_indite     = Commodity.create!([{ commodity_type_id: ct_minerals.id, name: 'Indite', galactic_average_price: 2118 }]).first
	c_lepidolite = Commodity.create!([{ commodity_type_id: ct_minerals.id, name: 'Lepidolite', galactic_average_price: 558 }]).first
	c_rutile     = Commodity.create!([{ commodity_type_id: ct_minerals.id, name: 'Rutile', galactic_average_price: 300 }]).first
	c_uraninite  = Commodity.create!([{ commodity_type_id: ct_minerals.id, name: 'Uraninite', galactic_average_price: 850 }]).first

	c_adv_catal  = Commodity.create!([{ commodity_type_id: ct_technology.id, name: 'Advanced Catalysers', galactic_average_price: 2812 }]).first
	c_animal_mon = Commodity.create!([{ commodity_type_id: ct_technology.id, name: 'Animal Monitors', galactic_average_price: 372 }]).first
	c_aquaponic  = Commodity.create!([{ commodity_type_id: ct_technology.id, name: 'Aquaponic Systems', galactic_average_price: 343 }]).first
	c_auto_fab   = Commodity.create!([{ commodity_type_id: ct_technology.id, name: 'Auto Fabricators', galactic_average_price: 3931 }]).first
	c_bio_red_li = Commodity.create!([{ commodity_type_id: ct_technology.id, name: 'Bio Reducing Lichen', galactic_average_price: 950 }]).first
	c_comp_comp  = Commodity.create!([{ commodity_type_id: ct_technology.id, name: 'Computer Components', galactic_average_price: 625 }]).first
	c_he_suits   = Commodity.create!([{ commodity_type_id: ct_technology.id, name: 'HE Suits', galactic_average_price: 266 }]).first
	c_land_enr   = Commodity.create!([{ commodity_type_id: ct_technology.id, name: 'Land Enrichment Systems', galactic_average_price: 5082 }]).first
	c_reson_sep  = Commodity.create!([{ commodity_type_id: ct_technology.id, name: 'Resonating Separators', galactic_average_price: 5887 }]).first
	c_robotics   = Commodity.create!([{ commodity_type_id: ct_technology.id, name: 'Robotics', galactic_average_price: 1970 }]).first

	c_leather    = Commodity.create!([{ commodity_type_id: ct_textiles.id, name: 'Leather', galactic_average_price: 233 }]).first
	c_natur_fab  = Commodity.create!([{ commodity_type_id: ct_textiles.id, name: 'Natural Fabrics', galactic_average_price: 487 }]).first
	c_synth_fab  = Commodity.create!([{ commodity_type_id: ct_textiles.id, name: 'Synthetic Fabrics', galactic_average_price: 174 }]).first

	c_biowaste   = Commodity.create!([{ commodity_type_id: ct_waste.id, name: 'Biowaste', galactic_average_price: 46 }]).first
	c_chem_waste = Commodity.create!([{ commodity_type_id: ct_waste.id, name: 'Chemical Waste', galactic_average_price: 80 }]).first
	c_scrap      = Commodity.create!([{ commodity_type_id: ct_waste.id, name: 'Scrap', galactic_average_price: 56 }]).first

	# c_battle_wep = Commodity.create!([{ commodity_type_id: ct_weapons.id, name: 'Battle Weapons', galactic_average_price: 0 }]).first
	c_non_lethal = Commodity.create!([{ commodity_type_id: ct_weapons.id, name: 'Non-Lethal Weapons', galactic_average_price: 1764 }]).first
	c_pers_wep   = Commodity.create!([{ commodity_type_id: ct_weapons.id, name: 'Personal Weapons', galactic_average_price: 4469 }]).first
	c_react_arm  = Commodity.create!([{ commodity_type_id: ct_weapons.id, name: 'Reactive Armour', galactic_average_price: 2025 }]).first

	# Station Types
	StationType.delete_all
	st_coriolis  = StationType.create!([{ name: 'Coriolis', has_small_dock: true, has_medium_dock: true, has_large_dock: true }]).first
	st_ring      = StationType.create!([{ name: 'Ring', has_small_dock: true, has_medium_dock: true, has_large_dock: true }]).first
	st_hub       = StationType.create!([{ name: 'Hub', has_small_dock: true, has_medium_dock: false, has_large_dock: false }]).first

	# Alliances
	Alliance.delete_all
	a_none       = Alliance.create!([{ name: 'None' }]).first
	a_empire     = Alliance.create!([{ name: 'Empire' }]).first
  	a_indendent  = Alliance.create!([{ name: 'Independent' }]).first
  	a_federation = Alliance.create!([{ name: 'Federation' }]).first
  	a_alliance   = Alliance.create!([{ name: 'Alliance' }]).first

  	# systems
  	System.delete_all
  	sy_apoyota   = System.create!([{ alliance_id: a_indendent.id, name: 'Apoyota' }]).first
  	sy_eravate   = System.create!([{ alliance_id: a_indendent.id, name: 'Eravate' }]).first
  	sy_frigaha   = System.create!([{ alliance_id: a_federation.id, name: 'Frigaha' }]).first
  	sy_gd219     = System.create!([{ alliance_id: a_federation.id, name: 'GD219' }]).first
  	sy_kremainn  = System.create!([{ alliance_id: a_federation.id, name: 'Kremainn' }]).first
  	sy_lhs_3447  = System.create!([{ alliance_id: a_federation.id, name: 'LHS 3447' }]).first
  	sy_potriti   = System.create!([{ alliance_id: a_federation.id, name: 'Potriti' }]).first

  	# stations
  	Station.delete_all
  	# system apoyota
	s_flint_station     = Station.create!([{ system_id: sy_apoyota.id, station_type_id: st_hub.id, name: 'Flint Station', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: false, has_outfitting: false, has_shipyard: false }]).first

  	# system eravate
  	s_ackerman_market   = Station.create!([{ system_id: sy_eravate.id, station_type_id: st_ring.id, name: 'Ackerman Market', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: true, has_shipyard: true }]).first
  	s_cleve_hub         = Station.create!([{ system_id: sy_eravate.id, station_type_id: st_ring.id, name: 'Cleve Hub', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: true, has_shipyard: true }]).first
  	s_main_hub          = Station.create!([{ system_id: sy_eravate.id, station_type_id: st_hub.id, name: 'Maine Hub', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: false, has_outfitting: true, has_shipyard: false }]).first
	s_mcmahon_dock      = Station.create!([{ system_id: sy_eravate.id, station_type_id: st_hub.id, name: 'McMahon Dock', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: false, has_outfitting: false, has_shipyard: false }]).first
  	s_russel_ring       = Station.create!([{ system_id: sy_eravate.id, station_type_id: st_ring.id, name: 'Russel Ring', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: true, has_shipyard: true }]).first
  	s_sylvestor_city    = Station.create!([{ system_id: sy_eravate.id, station_type_id: st_hub.id, name: 'Sylvestor City', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: false, has_outfitting: false, has_shipyard: false }]).first

  	# system frigaha
  	s_engle_orbital     = Station.create!([{ system_id: sy_frigaha.id, station_type_id: st_coriolis.id, name: 'Engle Orbital', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: true, has_shipyard: true }]).first

  	# system gd219
  	s_mckee_ring        = Station.create!([{ system_id: sy_gd219.id, station_type_id: st_coriolis.id, name: 'McKee Ring', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: true, has_shipyard: true }]).first

  	# system kremainn
  	s_volta_station     = Station.create!([{ system_id: sy_kremainn.id, station_type_id: st_hub.id, name: 'Volta Station', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: false, has_shipyard: false }]).first
  	s_wohler_terminal   = Station.create!([{ system_id: sy_kremainn.id, station_type_id: st_coriolis.id, name: 'Wohler Terminal', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: true, has_shipyard: true }]).first

  	# system lhs 3447
  	s_dalton_gateway    = Station.create!([{ system_id: sy_lhs_3447.id, station_type_id: st_coriolis.id, name: 'Dalton Gateway', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: true, has_shipyard: true }]).first
	s_fairbairn_station = Station.create!([{ system_id: sy_lhs_3447.id, station_type_id: st_hub.id, name: 'FairBairn Station', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: false, has_outfitting: true, has_shipyard: false }]).first
	s_oleskiw_station   = Station.create!([{ system_id: sy_lhs_3447.id, station_type_id: st_hub.id, name: 'Oleskiw Station', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: false, has_shipyard: false }]).first
	s_trevithick_dock   = Station.create!([{ system_id: sy_lhs_3447.id, station_type_id: st_hub.id, name: 'Trevithick Dock', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: false, has_outfitting: false, has_shipyard: false }]).first
	s_worlidge_terminal = Station.create!([{ system_id: sy_lhs_3447.id, station_type_id: st_coriolis.id, name: 'Worlidge Terminal', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: true, has_shipyard: true }]).first
	s_yaping_enterprise = Station.create!([{ system_id: sy_lhs_3447.id, station_type_id: st_coriolis.id, name: 'Yaping Enterprise', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: true, has_shipyard: true }]).first

  	# system potriti
  	s_hartsfield_plant  = Station.create!([{ system_id: sy_potriti.id, station_type_id: st_hub.id, name: 'Hartsfield Plant', has_commodities: true, has_refuel: true, has_repair: true, has_re_arm: false, has_outfitting: false, has_shipyard: false }]).first
  	s_tuan_orbital      = Station.create!([{ system_id: sy_potriti.id, station_type_id: st_hub.id, name: 'Tuan Orbital', has_commodities: false, has_refuel: true, has_repair: true, has_re_arm: true, has_outfitting: false, has_shipyard: false }]).first

  	# station_commodities
  	StationCommodity.delete_all
  	# station LHS 3447 : Dalton Gateway
  	sc_list = [
  	  [ s_flint_station.id, c_explosives.id, 'D','L',303 ],
  	  [ s_flint_station.id, c_min_oil.id, 'D','L',194 ],
  	  [ s_flint_station.id, c_clothing.id, 'D','L',318 ],
  	  [ s_flint_station.id, c_cons_tech.id, 'D','M',7094 ],
  	  [ s_flint_station.id, c_dom_appl.id, 'D','L',532 ],
  	  [ s_flint_station.id, c_anim_meat.id, 'D','L',1298 ],
  	  [ s_flint_station.id, c_coffee.id, 'D','L',1365 ],
  	  [ s_flint_station.id, c_fish.id, 'D','L',407 ],
  	  [ s_flint_station.id, c_food_cart.id, 'D','L',175 ],
  	  [ s_flint_station.id, c_fruit.id, 'D','L',318 ],
  	  [ s_flint_station.id, c_grain.id, 'D','L',209 ],
  	  [ s_flint_station.id, c_synth_meat.id, 'D','M',328 ],
  	  [ s_flint_station.id, c_tea.id, 'D','L',1473 ],
  	  [ s_flint_station.id, c_beer.id, 'D','M',177 ],
  	  [ s_flint_station.id, c_liquor.id, 'D','L',688 ],
  	  [ s_flint_station.id, c_wine.id, 'D','L',255 ],
  	  [ s_flint_station.id, c_microb_fur.id, 'D','M',269 ],
  	  [ s_flint_station.id, c_min_extrct.id, 'D','L',545 ],
  	  [ s_flint_station.id, c_power_gen.id, 'D','L',532 ],
  	  [ s_flint_station.id, c_water_pur.id, 'D','L',305 ],
  	  [ s_flint_station.id, c_basic_meds.id, 'D','L',358 ],
  	  [ s_flint_station.id, c_perf_enh.id, 'D','M',7068 ],
  	  [ s_flint_station.id, c_prog_cells.id, 'D','M',7027 ],
  	  [ s_flint_station.id, c_indite.id, 'D','M',2252 ],
  	  [ s_flint_station.id, c_lepidolite.id, 'D','L',545 ],
  	  [ s_flint_station.id, c_adv_catal.id, 'D','M',3083 ],
  	  [ s_flint_station.id, c_bio_red_li.id, 'D','M',1099 ],
  	  [ s_flint_station.id, c_he_suits.id, 'D','M',353 ],
  	  [ s_flint_station.id, c_reson_sep.id, 'D','M',6232 ],
  	  [ s_flint_station.id, c_chem_waste.id, 'D','M',80 ],
  	  [ s_flint_station.id, c_scrap.id, 'D','L',71 ],
  	  [ s_flint_station.id, c_non_lethal.id, 'D','L',1888 ],
  	  [ s_flint_station.id, c_pers_wep.id, 'D','L',4338 ],
  	  [ s_flint_station.id, c_react_arm.id, 'D','L',2158 ],
  	  [ s_flint_station.id, c_hyd_fuel.id, 'S','L',103 ],
  	  [ s_flint_station.id, c_polymers.id, 'S','M',74 ],
  	  [ s_flint_station.id, c_semicond.id, 'S','M',784 ],
  	  [ s_flint_station.id, c_supercond.id, 'S','M',6519 ],
  	  [ s_flint_station.id, c_aluminium.id, 'S','M',248 ],
  	  [ s_flint_station.id, c_beryllium.id, 'S','L',8347 ],
   	  [ s_flint_station.id, c_copper.id, 'S','M',384 ],
  	  [ s_flint_station.id, c_gallium.id, 'S','L',5223 ],
  	  [ s_flint_station.id, c_gold.id, 'S','M',9341 ],
   	  [ s_flint_station.id, c_indium.id, 'S','M',5858 ],
  	  [ s_flint_station.id, c_lithium.id, 'S','M',1435 ],
  	  [ s_flint_station.id, c_palladium.id, 'S','M',13591 ],
  	  [ s_flint_station.id, c_silver.id, 'S','M',4806 ],
  	  [ s_flint_station.id, c_tantalum.id, 'S','M',3816 ],
  	  [ s_flint_station.id, c_titanium.id, 'S','M',896 ],
  	  [ s_flint_station.id, c_uranium.id, 'S','L',3646 ],
  	  [ s_flint_station.id, c_bauxite.id, 'S','M',73 ],
  	  [ s_flint_station.id, c_bertrand.id, 'S','M',2226 ],
  	  [ s_flint_station.id, c_coltan.id, 'S','M',1255 ],
  	  [ s_flint_station.id, c_gallite.id, 'S','M',1581 ],
  	  [ s_flint_station.id, c_rutile.id, 'S','M',247 ],
   	  [ s_flint_station.id, c_uraninite.id, 'S','M',751 ],
  	  [ s_flint_station.id, c_synth_fab.id, 'S','M',111 ],
  	  [ s_flint_station.id, c_biowaste.id, 'S','M',111 ],
   	  [ s_flint_station.id, c_cobalt.id, 'S','M',597 ],

  	  [ s_mckee_ring.id, c_min_oil.id, 'D','M',261 ],
  	  [ s_mckee_ring.id, c_clothing.id, 'D','L',331 ],
  	  [ s_mckee_ring.id, c_dom_appl.id, 'D','L',548 ],
  	  [ s_mckee_ring.id, c_anim_meat.id, 'D','L',1294 ],
  	  [ s_mckee_ring.id, c_fish.id, 'D','M',496 ],
  	  [ s_mckee_ring.id, c_food_cart.id, 'D','L',153 ],
  	  [ s_mckee_ring.id, c_fruit.id, 'D','M',397 ],
  	  [ s_mckee_ring.id, c_grain.id, 'D','M',377 ],
  	  [ s_mckee_ring.id, c_beer.id, 'D','M',241 ],
  	  [ s_mckee_ring.id, c_liquor.id, 'D','M',743 ],
  	  [ s_mckee_ring.id, c_wine.id, 'D','M',326 ],
  	  [ s_mckee_ring.id, c_power_gen.id, 'D','L',548 ],
  	  [ s_mckee_ring.id, c_water_pur.id, 'D','L',315 ],
  	  [ s_mckee_ring.id, c_beryllium.id, 'D','L',8155 ],
  	  [ s_mckee_ring.id, c_gallium.id, 'D','L',5125 ],
  	  [ s_mckee_ring.id, c_gold.id, 'D','L',9316 ],
  	  [ s_mckee_ring.id, c_lithium.id, 'D','M',1680 ],
  	  [ s_mckee_ring.id, c_palladium.id, 'D','M',13462 ],
  	  [ s_mckee_ring.id, c_silver.id, 'D','L',4798 ],
  	  [ s_mckee_ring.id, c_tantalum.id, 'D','M',4151 ],
  	  [ s_mckee_ring.id, c_uranium.id, 'D','L',2664 ],
  	  [ s_mckee_ring.id, c_bauxite.id, 'D','L',164 ],
  	  [ s_mckee_ring.id, c_bertrand.id, 'D','L',2485 ],
  	  [ s_mckee_ring.id, c_coltan.id, 'D','L',1409 ],
  	  [ s_mckee_ring.id, c_gallite.id, 'D','L',1931 ],
  	  [ s_mckee_ring.id, c_indite.id, 'D','L',2195 ],
  	  [ s_mckee_ring.id, c_lepidolite.id, 'D','L',612 ],
  	  [ s_mckee_ring.id, c_rutile.id, 'D','L',346 ],
  	  [ s_mckee_ring.id, c_uraninite.id, 'D','L',918 ],
  	  [ s_mckee_ring.id, c_comp_comp.id, 'D','L',548 ],
  	  [ s_mckee_ring.id, c_chem_waste.id, 'D','M',99 ],
  	  [ s_mckee_ring.id, c_cobalt.id, 'D','L',726 ],
  	  [ s_mckee_ring.id, c_platinum.id, 'D','M',13462 ],
  	  [ s_mckee_ring.id, c_explosives.id, 'S','M',220 ],
  	  [ s_mckee_ring.id, c_hyd_fuel.id, 'S','H',94 ],
  	  [ s_mckee_ring.id, c_pesticides.id, 'S','H',117 ],
  	  [ s_mckee_ring.id, c_cons_tech.id, 'S','M',6494 ],
  	  [ s_mckee_ring.id, c_coffee.id, 'S','H',1050 ],
  	  [ s_mckee_ring.id, c_synth_meat.id, 'S','M',179 ],
  	  [ s_mckee_ring.id, c_tea.id, 'S','H',1206 ],
  	  [ s_mckee_ring.id, c_polymers.id, 'S','M',741 ],
  	  [ s_mckee_ring.id, c_semicond.id, 'S','M',777 ],
  	  [ s_mckee_ring.id, c_supercond.id, 'S','H',6219 ],
  	  [ s_mckee_ring.id, c_microb_fur.id, 'S','M',124 ],
  	  [ s_mckee_ring.id, c_basic_meds.id, 'S','M',211 ],
  	  [ s_mckee_ring.id, c_perf_enh.id, 'S','M',6517 ],
  	  [ s_mckee_ring.id, c_prog_cells.id, 'S','M',6679 ],
  	  [ s_mckee_ring.id, c_aluminium.id, 'S','M',247 ],
  	  [ s_mckee_ring.id, c_copper.id, 'S','M',383 ],
  	  [ s_mckee_ring.id, c_indium.id, 'S','H',5447 ],
  	  [ s_mckee_ring.id, c_titanium.id, 'S','M',895 ],
  	  [ s_mckee_ring.id, c_adv_catal.id, 'S','M',2669 ],
  	  [ s_mckee_ring.id, c_animal_mon.id, 'S','M',182 ],
  	  [ s_mckee_ring.id, c_aquaponic.id, 'S','H',161 ],
  	  [ s_mckee_ring.id, c_auto_fab.id, 'S','M',3510 ],
  	  [ s_mckee_ring.id, c_bio_red_li.id, 'S','M',8331 ],
  	  [ s_mckee_ring.id, c_he_suits.id, 'S','M',197 ],
  	  [ s_mckee_ring.id, c_reson_sep.id, 'S','M',5707 ],
  	  [ s_mckee_ring.id, c_robotics.id, 'S','M',1636 ],
  	  [ s_mckee_ring.id, c_land_enr.id, 'S','H',4313 ],
  	  [ s_mckee_ring.id, c_synth_fab.id, 'S','M',111 ],
  	  [ s_mckee_ring.id, c_biowaste.id, 'S','H',14 ],
  	  [ s_mckee_ring.id, c_scrap.id, 'S','M',41 ],
  	  [ s_mckee_ring.id, c_non_lethal.id, 'S','H',1495 ],
  	  [ s_mckee_ring.id, c_pers_wep.id, 'S','M',3879 ],
  	  [ s_mckee_ring.id, c_react_arm.id, 'S','M',1720 ],
  	  [ s_mckee_ring.id, c_agric_meds.id, 'S','H',799 ],

	  [ s_dalton_gateway.id, c_pesticides.id, 'D','M',293 ],
	  [ s_dalton_gateway.id, c_clothing.id, 'D','M',363 ],
	  [ s_dalton_gateway.id, c_cons_tech.id, 'D','M',7048 ],
	  [ s_dalton_gateway.id, c_dom_appl.id, 'D','M',569 ],
	  [ s_dalton_gateway.id, c_crop_harv.id, 'D','M',2323 ],
	  [ s_dalton_gateway.id, c_agrichem.id, 'D','M',1157 ],
	  [ s_dalton_gateway.id, c_perf_enh.id, 'D','M',7048 ],
	  [ s_dalton_gateway.id, c_prog_cells.id, 'D','M',7048 ],
	  [ s_dalton_gateway.id, c_animal_mon.id, 'D','M',379 ],
	  [ s_dalton_gateway.id, c_aquaponic.id, 'D','M',350 ],
	  [ s_dalton_gateway.id, c_land_enr.id, 'D','M',5100 ],
	  [ s_dalton_gateway.id, c_biowaste.id, 'D','M',175 ],
	  [ s_dalton_gateway.id, c_non_lethal.id, 'D','M',1988 ],
	  [ s_dalton_gateway.id, c_react_arm.id, 'D','M',2240 ],
	  [ s_dalton_gateway.id, c_hyd_fuel.id, 'S','H',94 ],
	  [ s_dalton_gateway.id, c_min_oil.id, 'S','M',117 ],
	  [ s_dalton_gateway.id, c_algae.id, 'S','M',52 ],
	  [ s_dalton_gateway.id, c_anim_meat.id, 'S','H',1055 ],
	  [ s_dalton_gateway.id, c_coffee.id, 'S','M',1127 ],
	  [ s_dalton_gateway.id, c_fish.id, 'S','M',318 ],
	  [ s_dalton_gateway.id, c_fruit.id, 'S','M',221 ],
	  [ s_dalton_gateway.id, c_grain.id, 'S','H',105 ],
	  [ s_dalton_gateway.id, c_tea.id, 'S','M',1337 ],
	  [ s_dalton_gateway.id, c_beer.id, 'S','M',100 ],
	  [ s_dalton_gateway.id, c_wine.id, 'S','M',177 ],
	  [ s_dalton_gateway.id, c_leather.id, 'S','M',99 ],
	  [ s_dalton_gateway.id, c_natur_fab.id, 'S','M',318 ],

	  [ s_worlidge_terminal.id, c_explosives.id, 'D','M',365 ],
	  [ s_worlidge_terminal.id, c_cons_tech.id, 'D','M',7048 ],
	  [ s_worlidge_terminal.id, c_synth_meat.id, 'D','M',325 ],
	  [ s_worlidge_terminal.id, c_liquor.id, 'D','M',687 ],
	  [ s_worlidge_terminal.id, c_min_extrct.id, 'D','M',673 ],
	  [ s_worlidge_terminal.id, c_perf_enh.id, 'D','M',7048 ],
	  [ s_worlidge_terminal.id, c_prog_cells.id, 'D','M',7048 ],
	  [ s_worlidge_terminal.id, c_bio_red_li.id, 'D','M',1092 ],
	  [ s_worlidge_terminal.id, c_he_suits.id, 'D','M',350 ],
	  [ s_worlidge_terminal.id, c_non_lethal.id, 'D','M',1981 ],
	  [ s_worlidge_terminal.id, c_react_arm.id, 'D','M',2240 ],
	  [ s_worlidge_terminal.id, c_hyd_fuel.id, 'S','H',94 ],
	  [ s_worlidge_terminal.id, c_cobalt.id, 'S','M',599 ],
	  [ s_worlidge_terminal.id, c_gold.id, 'S','M',9259 ],
	  [ s_worlidge_terminal.id, c_palladium.id, 'S','M',13145 ],
	  [ s_worlidge_terminal.id, c_silver.id, 'S','M',4617 ],
	  [ s_worlidge_terminal.id, c_bauxite.id, 'S','M',74 ],
	  [ s_worlidge_terminal.id, c_bertrand.id, 'S','H',2149 ],
	  [ s_worlidge_terminal.id, c_coltan.id, 'S','M',1257 ],
	  [ s_worlidge_terminal.id, c_gallite.id, 'S','M',1771 ],
	  [ s_worlidge_terminal.id, c_indite.id, 'S','M',2030 ],
	  [ s_worlidge_terminal.id, c_lepidolite.id, 'S','H',430 ],
	  [ s_worlidge_terminal.id, c_rutile.id, 'S','M',249 ],
	  [ s_worlidge_terminal.id, c_uraninite.id, 'S','M',781 ],
	  [ s_worlidge_terminal.id, c_biowaste.id, 'S','M',19 ],

	  [ s_yaping_enterprise.id, c_explosives.id, 'D','M',421 ],
	  [ s_yaping_enterprise.id, c_clothing.id, 'D','M',405 ],
	  [ s_yaping_enterprise.id, c_cons_tech.id, 'D','M',7360 ],
	  [ s_yaping_enterprise.id, c_dom_appl.id, 'D','M',645 ],
	  [ s_yaping_enterprise.id, c_anim_meat.id, 'D','M',1511 ],
	  [ s_yaping_enterprise.id, c_coffee.id, 'D','M',1540 ],
	  [ s_yaping_enterprise.id, c_fish.id, 'D','M',534 ],
	  [ s_yaping_enterprise.id, c_food_cart.id, 'D','M',234 ],
	  [ s_yaping_enterprise.id, c_fruit.id, 'D','M',430 ],
	  [ s_yaping_enterprise.id, c_grain.id, 'D','M',305 ],
	  [ s_yaping_enterprise.id, c_synth_meat.id, 'D','H',366 ],
	  [ s_yaping_enterprise.id, c_tea.id, 'D','M',1733 ],
	  [ s_yaping_enterprise.id, c_beer.id, 'D','M',248 ],
	  [ s_yaping_enterprise.id, c_liquor.id, 'D','M',782 ],
	  [ s_yaping_enterprise.id, c_wine.id, 'D','M',334 ],
	  [ s_yaping_enterprise.id, c_min_extrct.id, 'D','M',756 ],
	  [ s_yaping_enterprise.id, c_power_gen.id, 'D','M',645 ],
	  [ s_yaping_enterprise.id, c_water_pur.id, 'D','M',389 ],
	  [ s_yaping_enterprise.id, c_basic_meds.id, 'D','M',405 ],
	  [ s_yaping_enterprise.id, c_perf_enh.id, 'D','M',7360 ],
	  [ s_yaping_enterprise.id, c_prog_cells.id, 'D','M',7360 ],
	  [ s_yaping_enterprise.id, c_bio_red_li.id, 'D','M',1185 ],
	  [ s_yaping_enterprise.id, c_he_suits.id, 'D','M',398 ],
	  [ s_yaping_enterprise.id, c_non_lethal.id, 'D','H',2153 ],
	  [ s_yaping_enterprise.id, c_react_arm.id, 'D','H',2474 ],
	  [ s_yaping_enterprise.id, c_hyd_fuel.id, 'S','M',107 ],
	  [ s_yaping_enterprise.id, c_cobalt.id, 'S','M',664 ],
	  [ s_yaping_enterprise.id, c_gold.id, 'S','M',9673 ],
	  [ s_yaping_enterprise.id, c_palladium.id, 'S','M',13669 ],
	  [ s_yaping_enterprise.id, c_silver.id, 'S','M',4876 ],
	  [ s_yaping_enterprise.id, c_bauxite.id, 'S','M',91 ],
	  [ s_yaping_enterprise.id, c_bertrand.id, 'S','M',2340 ],
	  [ s_yaping_enterprise.id, c_coltan.id, 'S','M',1365 ],
	  [ s_yaping_enterprise.id, c_gallite.id, 'S','M',1907 ],
	  [ s_yaping_enterprise.id, c_indite.id, 'S','M',2179 ],
	  [ s_yaping_enterprise.id, c_lepidolite.id, 'S','M',502 ],
	  [ s_yaping_enterprise.id, c_rutile.id, 'S','M',285 ],
	  [ s_yaping_enterprise.id, c_uraninite.id, 'S','M',859 ],

	  [ s_hartsfield_plant.id, c_cons_tech.id, 'D','M',7073 ],
	  [ s_hartsfield_plant.id, c_synth_meat.id, 'D','M',326 ],
	  [ s_hartsfield_plant.id, c_perf_enh.id, 'D','M',7074 ],
	  [ s_hartsfield_plant.id, c_prog_cells.id, 'D','M',7075 ],
	  [ s_hartsfield_plant.id, c_gallite.id, 'D','M',1972 ],
	  [ s_hartsfield_plant.id, c_indite.id, 'D','M',2298 ],
	  [ s_hartsfield_plant.id, c_uraninite.id, 'D','M',960 ],
	  [ s_hartsfield_plant.id, c_adv_catal.id, 'D','M',3073 ],
	  [ s_hartsfield_plant.id, c_bio_red_li.id, 'D','M',1096 ],
	  [ s_hartsfield_plant.id, c_he_suits.id, 'D','M',352 ],
	  [ s_hartsfield_plant.id, c_reson_sep.id, 'D','M',6195 ],
	  [ s_hartsfield_plant.id, c_chem_waste.id, 'D','M',79 ],
	  [ s_hartsfield_plant.id, c_non_lethal.id, 'D','M',1994 ],
	  [ s_hartsfield_plant.id, c_react_arm.id, 'D','M',2251 ],
	  [ s_hartsfield_plant.id, c_explosives.id, 'S','M',222 ],
	  [ s_hartsfield_plant.id, c_hyd_fuel.id, 'S','M',94 ],
	  [ s_hartsfield_plant.id, c_coffee.id, 'S','H',1119 ],
	  [ s_hartsfield_plant.id, c_food_cart.id, 'S','H',54 ],
	  [ s_hartsfield_plant.id, c_polymers.id, 'S','M',74 ],
	  [ s_hartsfield_plant.id, c_semicond.id, 'S','M',776 ],
	  [ s_hartsfield_plant.id, c_supercond.id, 'S','M',6491 ],
	  [ s_hartsfield_plant.id, c_aluminium.id, 'S','M',247 ],
	  [ s_hartsfield_plant.id, c_beryllium.id, 'S','M',8305 ],
	  [ s_hartsfield_plant.id, c_cobalt.id, 'S','M',595 ],
	  [ s_hartsfield_plant.id, c_copper.id, 'S','M',383 ],
	  [ s_hartsfield_plant.id, c_gallium.id, 'S','M',4949 ],
	  [ s_hartsfield_plant.id, c_gold.id, 'S','M',9352 ],
	  [ s_hartsfield_plant.id, c_indium.id, 'S','M',5697 ],
	  [ s_hartsfield_plant.id, c_lithium.id, 'S','M',1429 ],
	  [ s_hartsfield_plant.id, c_silver.id, 'S','M',4744 ],
	  [ s_hartsfield_plant.id, c_tantalum.id, 'S','M',3765 ],
	  [ s_hartsfield_plant.id, c_titanium.id, 'S','M',894 ],
	  [ s_hartsfield_plant.id, c_uranium.id, 'S','M',2553 ],
	  [ s_hartsfield_plant.id, c_bauxite.id, 'S','M',75 ],
	  [ s_hartsfield_plant.id, c_rutile.id, 'S','M',215 ],
	  [ s_hartsfield_plant.id, c_synth_fab.id, 'S','M',111 ],

	  [ s_wohler_terminal.id, c_cons_tech.id, 'D','M',7054 ],
	  [ s_wohler_terminal.id, c_synth_meat.id, 'D','M',326 ],
	  [ s_wohler_terminal.id, c_microb_fur.id, 'D','M',267 ],
	  [ s_wohler_terminal.id, c_perf_enh.id, 'D','M',7054 ],
	  [ s_wohler_terminal.id, c_prog_cells.id, 'D','M',7054 ],
	  [ s_wohler_terminal.id, c_palladium.id, 'D','M',13413 ],
	  [ s_wohler_terminal.id, c_platinum.id, 'D','M',18876 ],
	  [ s_wohler_terminal.id, c_bertrand.id, 'D','M',2554 ],
	  [ s_wohler_terminal.id, c_coltan.id, 'D','M',1476 ],
	  [ s_wohler_terminal.id, c_gallite.id, 'D','M',2093 ],
	  [ s_wohler_terminal.id, c_indite.id, 'D','M',2386 ],
	  [ s_wohler_terminal.id, c_lepidolite.id, 'D','M',666 ],
	  [ s_wohler_terminal.id, c_rutile.id, 'D','M',403 ],
	  [ s_wohler_terminal.id, c_uraninite.id, 'D','M',1030 ],
	  [ s_wohler_terminal.id, c_adv_catal.id, 'D','M',3065 ],
	  [ s_wohler_terminal.id, c_auto_fab.id, 'D','M',3950 ],
	  [ s_wohler_terminal.id, c_he_suits.id, 'D','M',351 ],
	  [ s_wohler_terminal.id, c_reson_sep.id, 'D','M',6196 ],
	  [ s_wohler_terminal.id, c_robotics.id, 'D','M',1983 ],
	  [ s_wohler_terminal.id, c_chem_waste.id, 'D','M',79 ],
	  [ s_wohler_terminal.id, c_non_lethal.id, 'D','M',1962 ],
	  [ s_wohler_terminal.id, c_react_arm.id, 'D','M',2242 ],
	  [ s_wohler_terminal.id, c_explosives.id, 'S','H',195 ],
	  [ s_wohler_terminal.id, c_hyd_fuel.id, 'S','H',93 ],
	  [ s_wohler_terminal.id, c_clothing.id, 'S','H',202 ],
	  [ s_wohler_terminal.id, c_food_cart.id, 'S','H',44 ],
	  [ s_wohler_terminal.id, c_polymers.id, 'S','M',75 ],
	  [ s_wohler_terminal.id, c_semicond.id, 'S','M',779 ],
	  [ s_wohler_terminal.id, c_supercond.id, 'S','M',6490 ],
	  [ s_wohler_terminal.id, c_atmos_proc.id, 'S','M',316 ],
	  [ s_wohler_terminal.id, c_crop_harv.id, 'S','M',2015 ],
	  [ s_wohler_terminal.id, c_marine_eq.id, 'S','M',3984 ],
	  [ s_wohler_terminal.id, c_min_extrct.id, 'S','M',491 ],
	  [ s_wohler_terminal.id, c_power_gen.id, 'S','M',383 ],
	  [ s_wohler_terminal.id, c_basic_meds.id, 'S','M',233 ],
	  [ s_wohler_terminal.id, c_aluminium.id, 'S','M',249 ],
	  [ s_wohler_terminal.id, c_beryllium.id, 'S','H',7723 ],
	  [ s_wohler_terminal.id, c_cobalt.id, 'S','M',596 ],
	  [ s_wohler_terminal.id, c_copper.id, 'S','M',383 ],
	  [ s_wohler_terminal.id, c_gallium.id, 'S','M',4949 ],
	  [ s_wohler_terminal.id, c_gold.id, 'S','M',9211 ],
	  [ s_wohler_terminal.id, c_indium.id, 'S','H',5456 ],
	  [ s_wohler_terminal.id, c_lithium.id, 'S','H',1325 ],
	  [ s_wohler_terminal.id, c_silver.id, 'S','M',4596 ],
	  [ s_wohler_terminal.id, c_tantalum.id, 'S','M',3751 ],
	  [ s_wohler_terminal.id, c_titanium.id, 'S','M',894 ],
	  [ s_wohler_terminal.id, c_uranium.id, 'S','H',2316 ],
	  [ s_wohler_terminal.id, c_comp_comp.id, 'S','H',371 ],
	  [ s_wohler_terminal.id, c_synth_fab.id, 'S','M',112 ],
	  [ s_wohler_terminal.id, c_biowaste.id, 'S','M',19 ],

	  [ s_engle_orbital.id, c_explosives.id, 'D','L',316 ],
	  [ s_engle_orbital.id, c_min_oil.id, 'D','L',205 ],
	  [ s_engle_orbital.id, c_clothing.id, 'D','L',332 ],
	  [ s_engle_orbital.id, c_cons_tech.id, 'D','M',7041 ],
	  [ s_engle_orbital.id, c_dom_appl.id, 'D','L',549 ],
	  [ s_engle_orbital.id, c_anim_meat.id, 'D','L',1297 ],
	  [ s_engle_orbital.id, c_coffee.id, 'D','L',1297 ],
	  [ s_engle_orbital.id, c_fish.id, 'D','L',422 ],
	  [ s_engle_orbital.id, c_food_cart.id, 'D','L',143 ],
	  [ s_engle_orbital.id, c_fruit.id, 'D','L',332 ],
	  [ s_engle_orbital.id, c_grain.id, 'D','L',221 ],
	  [ s_engle_orbital.id, c_synth_meat.id, 'D','M',327 ],
	  [ s_engle_orbital.id, c_tea.id, 'D','L',1472 ],
	  [ s_engle_orbital.id, c_polymers.id, 'D','L',188 ],
	  [ s_engle_orbital.id, c_semicond.id, 'D','L',649 ],
	  [ s_engle_orbital.id, c_supercond.id, 'D','L',6267 ],
	  [ s_engle_orbital.id, c_microb_fur.id, 'D','M',289 ],
	  [ s_engle_orbital.id, c_min_extrct.id, 'D','L',613 ],
	  [ s_engle_orbital.id, c_power_gen.id, 'D','L',549 ],
	  [ s_engle_orbital.id, c_water_pur.id, 'D','L',316 ],
	  [ s_engle_orbital.id, c_basic_meds.id, 'D','L',318 ],
	  [ s_engle_orbital.id, c_perf_enh.id, 'D','M',7092 ],
	  [ s_engle_orbital.id, c_prog_cells.id, 'D','M',7092 ],
	  [ s_engle_orbital.id, c_bauxite.id, 'D','L',164 ],
	  [ s_engle_orbital.id, c_bertrand.id, 'D','L',2503 ],
	  [ s_engle_orbital.id, c_coltan.id, 'D','M',1451 ],
	  [ s_engle_orbital.id, c_gallite.id, 'D','L',1934 ],
	  [ s_engle_orbital.id, c_indite.id, 'D','M',2251 ],
	  [ s_engle_orbital.id, c_lepidolite.id, 'D','L',613 ],
	  [ s_engle_orbital.id, c_rutile.id, 'D','M',364 ],
	  [ s_engle_orbital.id, c_uraninite.id, 'D','M',950 ],
	  [ s_engle_orbital.id, c_adv_catal.id, 'D','M',3081 ],
	  [ s_engle_orbital.id, c_bio_red_li.id, 'D','M',1098 ],
	  [ s_engle_orbital.id, c_he_suits.id, 'D','M',352 ],
	  [ s_engle_orbital.id, c_reson_sep.id, 'D','M',6228 ],
	  [ s_engle_orbital.id, c_chem_waste.id, 'D','M',80 ],
	  [ s_engle_orbital.id, c_scrap.id, 'D','L',75 ],
	  [ s_engle_orbital.id, c_non_lethal.id, 'D','L',1886 ],
	  [ s_engle_orbital.id, c_react_arm.id, 'D','L',2140 ],
	  [ s_engle_orbital.id, c_hyd_fuel.id, 'S','H',94 ],
	  [ s_engle_orbital.id, c_aluminium.id, 'S','M',248 ],
	  [ s_engle_orbital.id, c_beryllium.id, 'S','M',8104 ],
	  [ s_engle_orbital.id, c_copper.id, 'S','M',384 ],
	  [ s_engle_orbital.id, c_gallium.id, 'S','M',4936 ],
	  [ s_engle_orbital.id, c_gold.id, 'S','M',9436 ],
	  [ s_engle_orbital.id, c_indium.id, 'S','M',5712 ],
	  [ s_engle_orbital.id, c_lithium.id, 'S','M',1444 ],
	  [ s_engle_orbital.id, c_palladium.id, 'S','L',13583 ],
	  [ s_engle_orbital.id, c_silver.id, 'S','M',4743 ],
	  [ s_engle_orbital.id, c_tantalum.id, 'S','M',3748 ],
	  [ s_engle_orbital.id, c_titanium.id, 'S','M',896 ],
	  [ s_engle_orbital.id, c_uranium.id, 'S','M',2509 ],
	  [ s_engle_orbital.id, c_cobalt.id, 'S','M',596 ],
	  [ s_engle_orbital.id, c_synth_fab.id, 'S','M',111 ],
	  [ s_engle_orbital.id, c_biowaste.id, 'S','M',24 ],

	  [ s_cleve_hub.id, c_cons_tech.id, 'D','M',7058 ],
	  [ s_cleve_hub.id, c_algae.id, 'D','L',147 ],
	  [ s_cleve_hub.id, c_anim_meat.id, 'D','L',1320 ],
	  [ s_cleve_hub.id, c_coffee.id, 'D','L',1320 ],
	  [ s_cleve_hub.id, c_fish.id, 'D','L',420 ],
	  [ s_cleve_hub.id, c_fruit.id, 'D','L',330 ],
	  [ s_cleve_hub.id, c_grain.id, 'D','L',220 ],
	  [ s_cleve_hub.id, c_synth_meat.id, 'D','M',326 ],
	  [ s_cleve_hub.id, c_tea.id, 'D','M',1496 ],
	  [ s_cleve_hub.id, c_polymers.id, 'D','M',199 ],
	  [ s_cleve_hub.id, c_semicond.id, 'D','M',1004 ],
	  [ s_cleve_hub.id, c_supercond.id, 'D','M',6665 ],
	  [ s_cleve_hub.id, c_beer.id, 'D','L',187 ],
	  [ s_cleve_hub.id, c_liquor.id, 'D','M',684 ],
	  [ s_cleve_hub.id, c_tobacco.id, 'D','L',4724 ],
	  [ s_cleve_hub.id, c_wine.id, 'D','L',266 ],
	  [ s_cleve_hub.id, c_agric_meds.id, 'D','M',1155 ],
	  [ s_cleve_hub.id, c_perf_enh.id, 'D','M',7058 ],
	  [ s_cleve_hub.id, c_prog_cells.id, 'D','M',7058 ],
	  [ s_cleve_hub.id, c_aluminium.id, 'D','M',409 ],
	  [ s_cleve_hub.id, c_beryllium.id, 'D','M',8563 ],
	  [ s_cleve_hub.id, c_copper.id, 'D','L',491 ],
	  [ s_cleve_hub.id, c_gallium.id, 'D','M',5235 ],
	  [ s_cleve_hub.id, c_gold.id, 'D','M',9598 ],
	  [ s_cleve_hub.id, c_indium.id, 'D','M',5933 ],
	  [ s_cleve_hub.id, c_lithium.id, 'D','M',1746 ],
	  [ s_cleve_hub.id, c_palladium.id, 'D','M',13577 ],
	  [ s_cleve_hub.id, c_silver.id, 'D','M',5094 ],
	  [ s_cleve_hub.id, c_tantalum.id, 'D','M',4114 ],
	  [ s_cleve_hub.id, c_titanium.id, 'D','M',1066 ],
	  [ s_cleve_hub.id, c_uranium.id, 'D','M',2871 ],
	  [ s_cleve_hub.id, c_cobalt.id, 'D','M',767 ],
	  [ s_cleve_hub.id, c_auto_fab.id, 'D','M',3952 ],
	  [ s_cleve_hub.id, c_he_suits.id, 'D','M',351 ],
	  [ s_cleve_hub.id, c_robotics.id, 'D','M',1984 ],
	  [ s_cleve_hub.id, c_leather.id, 'D','M',200 ],
	  [ s_cleve_hub.id, c_natur_fab.id, 'D','M',470 ],
	  [ s_cleve_hub.id, c_synth_fab.id, 'D','M',243 ],
	  [ s_cleve_hub.id, c_non_lethal.id, 'D','M',1867 ],
	  [ s_cleve_hub.id, c_react_arm.id, 'D','M',2236 ],
	  [ s_cleve_hub.id, c_platinum.id, 'D','M',18886 ],
	  [ s_cleve_hub.id, c_hyd_fuel.id, 'S','H',94 ],
	  [ s_cleve_hub.id, c_clothing.id, 'S','M',237 ],
	  [ s_cleve_hub.id, c_dom_appl.id, 'S','M',433 ],
	  [ s_cleve_hub.id, c_food_cart.id, 'S','M',45 ],
	  [ s_cleve_hub.id, c_atmos_proc.id, 'S','H',270 ],
	  [ s_cleve_hub.id, c_crop_harv.id, 'S','M',2032 ],
	  [ s_cleve_hub.id, c_marine_eq.id, 'S','M',4019 ],
	  [ s_cleve_hub.id, c_min_extrct.id, 'S','H',430 ],
	  [ s_cleve_hub.id, c_power_gen.id, 'S','H',375 ],
	  [ s_cleve_hub.id, c_water_pur.id, 'S','M',221 ],
	  [ s_cleve_hub.id, c_basic_meds.id, 'S','H',195 ],
	  [ s_cleve_hub.id, c_comp_comp.id, 'S','H',375 ],
	  [ s_cleve_hub.id, c_biowaste.id, 'S','M',19 ],
	  [ s_cleve_hub.id, c_scrap.id, 'S','H',33 ],

	  [ s_main_hub.id, c_cons_tech.id, 'D','M',7058 ],
	  [ s_main_hub.id, c_algae.id, 'D','L',147 ],
	  [ s_main_hub.id, c_anim_meat.id, 'D','L',1317 ],
	  [ s_main_hub.id, c_coffee.id, 'D','L',1317 ],
	  [ s_main_hub.id, c_fish.id, 'D','L',419 ],
	  [ s_main_hub.id, c_fruit.id, 'D','L',329 ],
	  [ s_main_hub.id, c_grain.id, 'D','L',219 ],
	  [ s_main_hub.id, c_synth_meat.id, 'D','M',325 ],
	  [ s_main_hub.id, c_tea.id, 'D','L',1492 ],
	  [ s_main_hub.id, c_polymers.id, 'D','M',211 ],
	  [ s_main_hub.id, c_semicond.id, 'D','M',1023 ],
	  [ s_main_hub.id, c_supercond.id, 'D','M',6647 ],
	  [ s_main_hub.id, c_beer.id, 'D','L',186 ],
	  [ s_main_hub.id, c_liquor.id, 'D','L',662 ],
	  [ s_main_hub.id, c_tobacco.id, 'D','L',4717 ],
	  [ s_main_hub.id, c_wine.id, 'D','L',265 ],
	  [ s_main_hub.id, c_perf_enh.id, 'D','M',7038 ],
	  [ s_main_hub.id, c_prog_cells.id, 'D','M',7038 ],
	  [ s_main_hub.id, c_aluminium.id, 'D','M',393 ],
	  [ s_main_hub.id, c_beryllium.id, 'D','M',8543 ],
	  [ s_main_hub.id, c_copper.id, 'D','M',528 ],
	  [ s_main_hub.id, c_gallium.id, 'D','M',5268 ],
	  [ s_main_hub.id, c_gold.id, 'D','M',9711 ],
	  [ s_main_hub.id, c_indium.id, 'D','M',5822 ],
	  [ s_main_hub.id, c_lithium.id, 'D','M',1743 ],
	  [ s_main_hub.id, c_palladium.id, 'D','M',13512 ],
	  [ s_main_hub.id, c_silver.id, 'D','M',5072 ],
	  [ s_main_hub.id, c_tantalum.id, 'D','M',4125 ],
	  [ s_main_hub.id, c_titanium.id, 'D','L',1030 ],
	  [ s_main_hub.id, c_uranium.id, 'D','M',2865 ],
	  [ s_main_hub.id, c_cobalt.id, 'D','L',733 ],
	  [ s_main_hub.id, c_auto_fab.id, 'D','M',3941 ],
	  [ s_main_hub.id, c_he_suits.id, 'D','M',350 ],
	  [ s_main_hub.id, c_robotics.id, 'D','M',1978 ],
	  [ s_main_hub.id, c_leather.id, 'D','L',186 ],
	  [ s_main_hub.id, c_natur_fab.id, 'D','M',486 ],
	  [ s_main_hub.id, c_synth_fab.id, 'D','M',221 ],
	  [ s_main_hub.id, c_non_lethal.id, 'D','M',1972 ],
	  [ s_main_hub.id, c_react_arm.id, 'D','M',2237 ],
	  [ s_main_hub.id, c_platinum.id, 'D','M',18834 ],
	  [ s_main_hub.id, c_hyd_fuel.id, 'S','H',94 ],
	  [ s_main_hub.id, c_clothing.id, 'S','M',234 ],
	  [ s_main_hub.id, c_dom_appl.id, 'S','M',432 ],
	  [ s_main_hub.id, c_food_cart.id, 'S','H',45 ],
	  [ s_main_hub.id, c_atmos_proc.id, 'S','H',274 ],
	  [ s_main_hub.id, c_crop_harv.id, 'S','M',2027 ],
	  [ s_main_hub.id, c_marine_eq.id, 'S','M',4008 ],
	  [ s_main_hub.id, c_min_extrct.id, 'S','H',429 ],
	  [ s_main_hub.id, c_power_gen.id, 'S','M',432 ],
	  [ s_main_hub.id, c_water_pur.id, 'S','M',220 ],
	  [ s_main_hub.id, c_basic_meds.id, 'S','H',195 ],
	  [ s_main_hub.id, c_comp_comp.id, 'S','H',373 ],
	  [ s_main_hub.id, c_biowaste.id, 'S','M',19 ],
	  [ s_main_hub.id, c_scrap.id, 'S','M',37 ],

	  [ s_russel_ring.id, c_cons_tech.id, 'D','M',7038 ],
	  [ s_russel_ring.id, c_algae.id, 'D','L',146 ],
	  [ s_russel_ring.id, c_anim_meat.id, 'D','L',1317 ],
	  [ s_russel_ring.id, c_coffee.id, 'D','L',1317 ],
	  [ s_russel_ring.id, c_fish.id, 'D','L',419 ],
	  [ s_russel_ring.id, c_fruit.id, 'D','L',329 ],
	  [ s_russel_ring.id, c_grain.id, 'D','L',219 ],
	  [ s_russel_ring.id, c_synth_meat.id, 'D','M',325 ],
	  [ s_russel_ring.id, c_tea.id, 'D','L',1492 ],
	  [ s_russel_ring.id, c_polymers.id, 'D','M',195 ],
	  [ s_russel_ring.id, c_semicond.id, 'D','M',996 ],
	  [ s_russel_ring.id, c_supercond.id, 'D','L',6647 ],
	  [ s_russel_ring.id, c_beer.id, 'D','L',186 ],
	  [ s_russel_ring.id, c_liquor.id, 'D','M',676 ],
	  [ s_russel_ring.id, c_tobacco.id, 'D','L',4710 ],
	  [ s_russel_ring.id, c_wine.id, 'D','L',265 ],
	  [ s_russel_ring.id, c_perf_enh.id, 'D','M',7038 ],
	  [ s_russel_ring.id, c_prog_cells.id, 'D','M',7038 ],
	  [ s_russel_ring.id, c_aluminium.id, 'D','M',407 ],
	  [ s_russel_ring.id, c_beryllium.id, 'D','M',8535 ],
	  [ s_russel_ring.id, c_copper.id, 'D','L',489 ],
	  [ s_russel_ring.id, c_gallium.id, 'D','M',5181 ],
	  [ s_russel_ring.id, c_gold.id, 'D','M',9538 ],
	  [ s_russel_ring.id, c_indium.id, 'D','L',5869 ],
	  [ s_russel_ring.id, c_lithium.id, 'D','M',1739 ],
	  [ s_russel_ring.id, c_palladium.id, 'D','M',13538 ],
	  [ s_russel_ring.id, c_silver.id, 'D','M',5077 ],
	  [ s_russel_ring.id, c_tantalum.id, 'D','M',4085 ],
	  [ s_russel_ring.id, c_titanium.id, 'D','L',1047 ],
	  [ s_russel_ring.id, c_uranium.id, 'D','M',2861 ],
	  [ s_russel_ring.id, c_cobalt.id, 'D','M',754 ],
	  [ s_russel_ring.id, c_auto_fab.id, 'D','M',3941 ],
	  [ s_russel_ring.id, c_he_suits.id, 'D','M',350 ],
	  [ s_russel_ring.id, c_robotics.id, 'D','M',1978 ],
	  [ s_russel_ring.id, c_leather.id, 'D','L',192 ],
	  [ s_russel_ring.id, c_natur_fab.id, 'D','M',464 ],
	  [ s_russel_ring.id, c_synth_fab.id, 'D','M',240 ],
	  [ s_russel_ring.id, c_non_lethal.id, 'D','M',1978 ],
	  [ s_russel_ring.id, c_react_arm.id, 'D','M',2231 ],
	  [ s_russel_ring.id, c_platinum.id, 'D','M',18834 ],
	  [ s_russel_ring.id, c_hyd_fuel.id, 'S','H',94 ],
	  [ s_russel_ring.id, c_clothing.id, 'S','M',236 ],
	  [ s_russel_ring.id, c_dom_appl.id, 'S','M',432 ],
	  [ s_russel_ring.id, c_food_cart.id, 'S','H',45 ],
	  [ s_russel_ring.id, c_atmos_proc.id, 'S','H',269 ],
	  [ s_russel_ring.id, c_crop_harv.id, 'S','M',2027 ],
	  [ s_russel_ring.id, c_marine_eq.id, 'S','M',4008 ],
	  [ s_russel_ring.id, c_min_extrct.id, 'S','H',429 ],
	  [ s_russel_ring.id, c_power_gen.id, 'S','H',373 ],
	  [ s_russel_ring.id, c_water_pur.id, 'S','M',220 ],
	  [ s_russel_ring.id, c_basic_meds.id, 'S','H',195 ],
	  [ s_russel_ring.id, c_comp_comp.id, 'S','H',373 ],
	  [ s_russel_ring.id, c_biowaste.id, 'S','M',19 ],
	  [ s_russel_ring.id, c_scrap.id, 'S','H',34 ],

	  [ s_ackerman_market.id, c_pesticides.id, 'D','M',293 ],
	  [ s_ackerman_market.id, c_clothing.id, 'D','M',351 ],
	  [ s_ackerman_market.id, c_cons_tech.id, 'D','M',7038 ],
	  [ s_ackerman_market.id, c_dom_appl.id, 'D','L',546 ],
	  [ s_ackerman_market.id, c_atmos_proc.id, 'D','L',404 ],
	  [ s_ackerman_market.id, c_crop_harv.id, 'D','M',2319 ],
	  [ s_ackerman_market.id, c_marine_eq.id, 'D','M',4311 ],
	  [ s_ackerman_market.id, c_power_gen.id, 'D','L',528 ],
	  [ s_ackerman_market.id, c_water_pur.id, 'D','L',301 ],
	  [ s_ackerman_market.id, c_basic_meds.id, 'D','L',316 ],
	  [ s_ackerman_market.id, c_perf_enh.id, 'D','M',7038 ],
	  [ s_ackerman_market.id, c_prog_cells.id, 'D','M',7038 ],
	  [ s_ackerman_market.id, c_animal_mon.id, 'D','M',379 ],
	  [ s_ackerman_market.id, c_aquaponic.id, 'D','M',350 ],
	  [ s_ackerman_market.id, c_land_enr.id, 'D','M',5093 ],
	  [ s_ackerman_market.id, c_biowaste.id, 'D','M',74 ],
	  [ s_ackerman_market.id, c_non_lethal.id, 'D','M',1978 ],
	  [ s_ackerman_market.id, c_react_arm.id, 'D','M',2237 ],
	  [ s_ackerman_market.id, c_hyd_fuel.id, 'S','H',94 ],
	  [ s_ackerman_market.id, c_min_oil.id, 'S','H',92 ],
	  [ s_ackerman_market.id, c_algae.id, 'S','M',50 ],
	  [ s_ackerman_market.id, c_anim_meat.id, 'S','H',1054 ],
	  [ s_ackerman_market.id, c_coffee.id, 'S','H',1054 ],
	  [ s_ackerman_market.id, c_fish.id, 'S','H',269 ],
	  [ s_ackerman_market.id, c_fruit.id, 'S','H',195 ],
	  [ s_ackerman_market.id, c_synth_meat.id, 'S','H',105 ],
	  [ s_ackerman_market.id, c_tea.id, 'S','H',1210 ],
	  [ s_ackerman_market.id, c_beer.id, 'S','H',80 ],
	  [ s_ackerman_market.id, c_liquor.id, 'S','M',535 ],
	  [ s_ackerman_market.id, c_tobacco.id, 'S','H',4329 ],
	  [ s_ackerman_market.id, c_wine.id, 'S','M',165 ],
	  [ s_ackerman_market.id, c_leather.id, 'S','M',99 ],
	  [ s_ackerman_market.id, c_natur_fab.id, 'S','M',317 ],

	  [ s_fairbairn_station.id, c_explosives.id, 'D','M',357 ],
	  [ s_fairbairn_station.id, c_clothing.id, 'D','L',330 ],
	  [ s_fairbairn_station.id, c_cons_tech.id, 'D','M',7048 ],
	  [ s_fairbairn_station.id, c_dom_appl.id, 'D','L',546 ],
	  [ s_fairbairn_station.id, c_anim_meat.id, 'D','L',1319 ],
	  [ s_fairbairn_station.id, c_coffee.id, 'D','L',1319 ],
	  [ s_fairbairn_station.id, c_fish.id, 'D','L',420 ],
	  [ s_fairbairn_station.id, c_food_cart.id, 'D','L',153 ],
	  [ s_fairbairn_station.id, c_fruit.id, 'D','L',330 ],
	  [ s_fairbairn_station.id, c_grain.id, 'D','L',219 ],
	  [ s_fairbairn_station.id, c_synth_meat.id, 'D','M',325 ],
	  [ s_fairbairn_station.id, c_tea.id, 'D','L',1494 ],
	  [ s_fairbairn_station.id, c_beer.id, 'D','L',187 ],
	  [ s_fairbairn_station.id, c_liquor.id, 'D','M',693 ],
	  [ s_fairbairn_station.id, c_wine.id, 'D','L',265 ],
	  [ s_fairbairn_station.id, c_min_extrct.id, 'D','M',676 ],
	  [ s_fairbairn_station.id, c_power_gen.id, 'D','L',546 ],
	  [ s_fairbairn_station.id, c_water_pur.id, 'D','L',314 ],
	  [ s_fairbairn_station.id, c_basic_meds.id, 'D','L',330 ],
	  [ s_fairbairn_station.id, c_perf_enh.id, 'D','M',7048 ],
	  [ s_fairbairn_station.id, c_prog_cells.id, 'D','M',7048 ],
	  [ s_fairbairn_station.id, c_bio_red_li.id, 'D','M',1092 ],
	  [ s_fairbairn_station.id, c_he_suits.id, 'D','M',350 ],
	  [ s_fairbairn_station.id, c_non_lethal.id, 'D','M',1981 ],
	  [ s_fairbairn_station.id, c_react_arm.id, 'D','M',2240 ],
	  [ s_fairbairn_station.id, c_hyd_fuel.id, 'S','H',94 ],
	  [ s_fairbairn_station.id, c_cobalt.id, 'S','H',526 ],
	  [ s_fairbairn_station.id, c_gold.id, 'S','M',9259 ],
	  [ s_fairbairn_station.id, c_palladium.id, 'S','M',13145 ],
	  [ s_fairbairn_station.id, c_silver.id, 'S','M',4617 ],
	  [ s_fairbairn_station.id, c_bauxite.id, 'S','H',56 ],
	  [ s_fairbairn_station.id, c_bertrand.id, 'S','M',2328 ],
	  [ s_fairbairn_station.id, c_coltan.id, 'S','M',1257 ],
	  [ s_fairbairn_station.id, c_gallite.id, 'S','M',1771 ],
	  [ s_fairbairn_station.id, c_indite.id, 'S','H',1925 ],
	  [ s_fairbairn_station.id, c_lepidolite.id, 'S','M',494 ],
	  [ s_fairbairn_station.id, c_rutile.id, 'S','H',208 ],
	  [ s_fairbairn_station.id, c_uraninite.id, 'S','H',720 ],
	  [ s_fairbairn_station.id, c_biowaste.id, 'S','M',19 ],

	  [ s_oleskiw_station.id, c_explosives.id, 'D','M',417 ],
	  [ s_oleskiw_station.id, c_clothing.id, 'D','M',405 ],
	  [ s_oleskiw_station.id, c_cons_tech.id, 'D','M',7360 ],
	  [ s_oleskiw_station.id, c_dom_appl.id, 'D','M',645 ],
	  [ s_oleskiw_station.id, c_anim_meat.id, 'D','M',1505 ],
	  [ s_oleskiw_station.id, c_coffee.id, 'D','M',1540 ],
	  [ s_oleskiw_station.id, c_fish.id, 'D','M',534 ],
	  [ s_oleskiw_station.id, c_food_cart.id, 'D','M',234 ],
	  [ s_oleskiw_station.id, c_fruit.id, 'D','M',430 ],
	  [ s_oleskiw_station.id, c_grain.id, 'D','M',305 ],
	  [ s_oleskiw_station.id, c_synth_meat.id, 'D','H',386 ],
	  [ s_oleskiw_station.id, c_tea.id, 'D','M',1733 ],
	  [ s_oleskiw_station.id, c_beer.id, 'D','M',248 ],
	  [ s_oleskiw_station.id, c_liquor.id, 'D','M',769 ],
	  [ s_oleskiw_station.id, c_wine.id, 'D','M',334 ],
	  [ s_oleskiw_station.id, c_min_extrct.id, 'D','M',749 ],
	  [ s_oleskiw_station.id, c_power_gen.id, 'D','M',645 ],
	  [ s_oleskiw_station.id, c_water_pur.id, 'D','M',389 ],
	  [ s_oleskiw_station.id, c_basic_meds.id, 'D','M',405 ],
	  [ s_oleskiw_station.id, c_perf_enh.id, 'D','M',7360 ],
	  [ s_oleskiw_station.id, c_prog_cells.id, 'D','M',7360 ],
	  [ s_oleskiw_station.id, c_bio_red_li.id, 'D','M',1185 ],
	  [ s_oleskiw_station.id, c_he_suits.id, 'D','M',398 ],
	  [ s_oleskiw_station.id, c_non_lethal.id, 'D','M',2152 ],
	  [ s_oleskiw_station.id, c_react_arm.id, 'D','M',2474 ],
	  [ s_oleskiw_station.id, c_hyd_fuel.id, 'S','M',107 ],
	  [ s_oleskiw_station.id, c_cobalt.id, 'S','M',664 ],
	  [ s_oleskiw_station.id, c_gold.id, 'S','M',9673 ],
	  [ s_oleskiw_station.id, c_palladium.id, 'S','M',13669 ],
	  [ s_oleskiw_station.id, c_silver.id, 'S','M',4876 ],
	  [ s_oleskiw_station.id, c_bauxite.id, 'S','M',91 ],
	  [ s_oleskiw_station.id, c_bertrand.id, 'S','M',2361 ],
	  [ s_oleskiw_station.id, c_coltan.id, 'S','M',1365 ],
	  [ s_oleskiw_station.id, c_gallite.id, 'S','M',1907 ],
	  [ s_oleskiw_station.id, c_indite.id, 'S','M',2179 ],
	  [ s_oleskiw_station.id, c_lepidolite.id, 'S','M',512 ],
	  [ s_oleskiw_station.id, c_rutile.id, 'S','M',265 ],
	  [ s_oleskiw_station.id, c_uraninite.id, 'S','M',859 ]

	  # [ s_.id, c_.id, 'D','M', ],
	  # [ s_.id, c_.id, 'S','M', ],

	]

	sc_list.each do |s_id, c_id, d_or_s, level, price|
	  StationCommodity.create!([{ station_id: s_id, commodity_id: c_id, demanded_or_supplied: d_or_s, demand_or_supply_level: level, buy_or_sell_price: price }])
	end








