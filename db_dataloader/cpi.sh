#!/bin/sh

get_cpi() {
  column=$1;
  shift

  echo '  gsub(/"/, "", $'$column') \
  { gsub(/^Fresh or frozen beef$/, "beef", $'$column') } \
  { gsub(/^Fresh or frozen pork$/, "pork", $'$column') } \
  { gsub(/^Other fresh or frozen meat \(excluding poultry\)$/, "meat_other", $'$column') } \
  { gsub(/^Fresh or frozen chicken$/, "chicken", $'$column') } \
  { gsub(/^Other fresh or frozen poultry$/, "poultry", $'$column') } \
  { gsub(/^Bacon$/, "bacon", $'$column') } \
  { gsub(/^Ham excluding deli ham$/, "ham", $'$column') } \
  { gsub(/^Other processed meat$/, "meat_processed_other", $'$column') } \
  { gsub(/^Fresh or frozen fish \(including portions and fish sticks\)$/, "fish_fresh_or_frozen", $'$column') } \
  { gsub(/^Canned salmon$/, "salmon_canned", $'$column') } \
  { gsub(/^Canned tuna$/, "tuna_canned", $'$column') } \
  { gsub(/^Shrimps and prawns$/, "shrimps", $'$column') } \
  { gsub(/^Other shellfish$/, "shellfish_other", $'$column') } \
  { gsub(/^Whole milk$/, "milk_whole", $'$column') } \
  { gsub(/^Low-fat milk$/, "milk_low-fat", $'$column') } \
  { gsub(/^Butter$/, "butter", $'$column') } \
  { gsub(/^Cheddar cheese$/, "cheddar", $'$column') } \
  { gsub(/^Processed cheese$/, "cheese_processed", $'$column') } \
  { gsub(/^Unripened or fresh cheese$/, "cheese_fresh", $'$column') } \
  { gsub(/^Mozzarella cheese$/, "mozzarella", $'$column') } \
  { gsub(/^Ice cream and related products$/, "ice_cream", $'$column') } \
  { gsub(/^Other dairy products$/, "dairy_other", $'$column') } \
  { gsub(/^Eggs$/, "eggs", $'$column') } \
  { gsub(/^Bread rolls and buns$/, "bread", $'$column') } \
  { gsub(/^Crackers and crisp breads$/, "crackers", $'$column') } \
  { gsub(/^Cookies and sweet biscuits$/, "cookies_and_biscuits", $'$column') } \
  { gsub(/^Other bakery products$/, "baked_other", $'$column') } \
  { gsub(/^Rice and rice-based mixes$/, "rice", $'$column') } \
  { gsub(/^Breakfast cereal and other cereal products \(excluding baby food\)$/, "cereal", $'$column') } \
  { gsub(/^Dry or fresh pasta$/, "pasta_fresh", $'$column') } \
  { gsub(/^Pasta mixes$/, "pasta_mixes", $'$column') } \
  { gsub(/^Flour and flour-based mixes$/, "flour", $'$column') } \
  { gsub(/^Apples$/, "apples", $'$column') } \
  { gsub(/^Oranges$/, "oranges", $'$column') } \
  { gsub(/^Bananas$/, "bananas", $'$column') } \
  { gsub(/^Other fresh fruit$/, "fruit_other", $'$column') } \
  { gsub(/^Fruit juices$/, "juices", $'$column') } \
  { gsub(/^Canned fruit$/, "fruit_canned", $'$column') } \
  { gsub(/^Jam jelly and other preserves$/, "preserves", $'$column') } \
  { gsub(/^Dried and dehydrated fruit$/, "fruit_dried", $'$column') } \
  { gsub(/^Frozen fruit$/, "fruit_frozen", $'$column') } \
  { gsub(/^Nuts and seeds$/, "nuts", $'$column') } \
  { gsub(/^Potatoes$/, "potatoes", $'$column') } \
  { gsub(/^Tomatoes$/, "tomatoes", $'$column') } \
  { gsub(/^Lettuce$/, "lettuce", $'$column') } \
  { gsub(/^Other fresh vegetables$/, "vegetables_other", $'$column') } \
  { gsub(/^Frozen and dried vegetables$/, "vegetables_dried", $'$column') } \
  { gsub(/^Canned vegetables and other vegetable preparations$/, "vegetables_canned", $'$column') } \
  { gsub(/^Sugar and syrup$/, "sugar_and_syrup", $'$column') } \
  { gsub(/^Confectionery$/, "confectionery", $'$column') } \
  { gsub(/^Margarine$/, "margarine", $'$column') } \
  { gsub(/^Other edible fats and oils$/, "fats_other", $'$column') } \
  { gsub(/^Roasted or ground coffee$/, "coffee_ground", $'$column') } \
  { gsub(/^Instant and other coffee$/, "coffee_instant", $'$column') } \
  { gsub(/^Tea$/, "tea", $'$column') } \
  { gsub(/^Fermented or pickled vegetables$/, "vegetables_pickled", $'$column') } \
  { gsub(/^Sauces condiments and dips$/, "sauces", $'$column') } \
  { gsub(/^Herbs spices and seasonings$/, "herbs", $'$column') } \
  { gsub(/^Soup$/, "soup", $'$column') } \
  { gsub(/^Canned infant or junior foods$/, "infant_canned", $'$column') } \
  { gsub(/^Infant formula$/, "infant_formula", $'$column') } \
  { gsub(/^Frozen food preparations$/, "pre-cooked_frozen", $'$column') } \
  { gsub(/^Nut butter$/, "nut_butter", $'$column') } \
  { gsub(/^Potato chips and other snack products n.e.c.$/, "chips", $'$column') } \
  { gsub(/^All other miscellaneous food preparations$/, "food_misc", $'$column') } \
  { gsub(/^Non-alcoholic beverages$/, "beverages_non-alcoholic", $'$column') } \
  { gsub(/^Food purchased from table-service restaurants$/, "table-service_food", $'$column') } \
  { gsub(/^Food purchased from fast food and take-out restaurants$/, "fast_food", $'$column') } \
  { gsub(/^Food purchased from cafeterias and other restaurants$/, "cafeteria_food", $'$column') } \
  { gsub(/^Rent$/, "rent", $'$column') } \
  { gsub(/^Tenants\x27 insurance premiums$/, "tenants_insurance", $'$column') } \
  { gsub(/^Tenants\x27 maintenance repairs and other expenses$/, "tenants_repairs", $'$column') } \
  { gsub(/^Mortgage interest cost$/, "mortgage_interest", $'$column') } \
  { gsub(/^Homeowners\x27 replacement cost$/, "homeowners_replacement", $'$column') } \
  { gsub(/^Property taxes and other special charges$/, "property_taxes", $'$column') } \
  { gsub(/^Homeowners\x27 home and mortgage insurance$/, "homeowners_insurance", $'$column') } \
  { gsub(/^Homeowners\x27 maintenance and repairs$/, "homeowners_repairs", $'$column') } \
  { gsub(/^Other owned accommodation expenses$/, "accommodation_expenses", $'$column') } \
  { gsub(/^Electricity$/, "electricity", $'$column') } \
  { gsub(/^Water$/, "water", $'$column') } \
  { gsub(/^Natural gas$/, "natural_gas", $'$column') } \
  { gsub(/^Fuel oil and other fuels$/, "oil", $'$column') } \
  { gsub(/^Telephone services$/, "telephone_services", $'$column') } \
  { gsub(/^Postal and other communications services$/, "postal", $'$column') } \
  { gsub(/^Internet access services$/, "internet", $'$column') } \
  { gsub(/^Telephone equipment$/, "telephone_equipment", $'$column') } \
  { gsub(/^Child care services$/, "child_care", $'$column') } \
  { gsub(/^Housekeeping services$/, "housekeeping", $'$column') } \
  { gsub(/^Laundry detergents and soaps$/, "detergents_laundry", $'$column') } \
  { gsub(/^Detergents and rinse agents for dish washing$/, "detergents_dishes", $'$column') } \
  { gsub(/^Household cleaning and polishing products$/, "cleaning_and_polishing_products", $'$column') } \
  { gsub(/^Bleach and other household chemical products$/, "household_chemicals", $'$column') } \
  { gsub(/^Fabric softener$/, "fabric_softener", $'$column') } \
  { gsub(/^Household paper supplies$/, "household_paper", $'$column') } \
  { gsub(/^Stationery$/, "stationery", $'$column') } \
  { gsub(/^Plastic supplies$/, "plastic_supplies", $'$column') } \
  { gsub(/^Foil supplies$/, "foil", $'$column') } \
  { gsub(/^Pet food and supplies$/, "pet_food", $'$column') } \
  { gsub(/^Seeds plants and cut flowers$/, "seeds", $'$column') } \
  { gsub(/^Other horticultural goods$/, "horticultural_goods", $'$column') } \
  { gsub(/^Other household supplies$/, "household_supplies", $'$column') } \
  { gsub(/^Other household services$/, "household_services", $'$column') } \
  { gsub(/^Financial services$/, "financial_services", $'$column') } \
  { gsub(/^Upholstered furniture$/, "furniture_upholstered", $'$column') } \
  { gsub(/^Wooden furniture$/, "furniture_wooden", $'$column') } \
  { gsub(/^Other furniture$/, "furniture_other", $'$column') } \
  { gsub(/^Window coverings$/, "window_cover", $'$column') } \
  { gsub(/^Bedding and other household textiles$/, "bedding", $'$column') } \
  { gsub(/^Area rugs and mats$/, "rugs", $'$column') } \
  { gsub(/^Cooking appliances$/, "cooking_appliances", $'$column') } \
  { gsub(/^Refrigerators and freezers$/, "refrigerators", $'$column') } \
  { gsub(/^Laundry and dishwashing appliances$/, "laundry_appliances", $'$column') } \
  { gsub(/^Other household appliances$/, "household_appliances", $'$column') } \
  { gsub(/^Non-electric kitchen utensils tableware and cookware$/, "utensils", $'$column') } \
  { gsub(/^Household tools \(including lawn garden and snow removal equipment\)$/, "household_tools", $'$column') } \
  { gsub(/^Other household equipment$/, "household_equipment_other", $'$column') } \
  { gsub(/^Services related to household furnishings and equipment$/, "furnishing_services", $'$column') } \
  { gsub(/^Women\x27s clothing$/, "clothing_women", $'$column') } \
  { gsub(/^Men\x27s clothing$/, "clothing_men", $'$column') } \
  { gsub(/^Children\x27s clothing$/, "clothing_kids", $'$column') } \
  { gsub(/^Women\x27s footwear \(excluding athletic\)$/, "footwear_women", $'$column') } \
  { gsub(/^Men\x27s footwear \(excluding athletic\)$/, "footwear_men", $'$column') } \
  { gsub(/^Children\x27s footwear \(excluding athletic\)$/, "footwear_kids", $'$column') } \
  { gsub(/^Athletic footwear$/, "footwear_athletic", $'$column') } \
  { gsub(/^Leather clothing accessories$/, "clothing_leather", $'$column') } \
  { gsub(/^Other clothing accessories$/, "clothing_accessories_other", $'$column') } \
  { gsub(/^Watches$/, "watches", $'$column') } \
  { gsub(/^Jewellery$/, "jewellery", $'$column') } \
  { gsub(/^Clothing material and notions$/, "clothing_material", $'$column') } \
  { gsub(/^Laundry services$/, "laundry_services", $'$column') } \
  { gsub(/^Dry cleaning services$/, "dry_cleaning", $'$column') } \
  { gsub(/^Other clothing services$/, "clothing_services", $'$column') } \
  { gsub(/^Purchase of automobiles$/, "car_purchase", $'$column') } \
  { gsub(/^Purchase of trucks vans and sport utility vehicles$/, "truck_purchase", $'$column') } \
  { gsub(/^Leasing of passenger vehicles$/, "vehicle_lease", $'$column') } \
  { gsub(/^Rental of passenger vehicles$/, "vehicle_rental", $'$column') } \
  { gsub(/^Gasoline$/, "gasoline", $'$column') } \
  { gsub(/^Passenger vehicle parts accessories and supplies$/, "vehicle_parts", $'$column') } \
  { gsub(/^Passenger vehicle maintenance and repair services$/, "vehicle_repairs", $'$column') } \
  { gsub(/^Passenger vehicle insurance premiums$/, "vehicle_insurance", $'$column') } \
  { gsub(/^Passenger vehicle registration fees$/, "vehicle_registration_fees", $'$column') } \
  { gsub(/^Drivers\x27 licences$/, "drivers_licences", $'$column') } \
  { gsub(/^Parking fees$/, "parking_fees", $'$column') } \
  { gsub(/^All other passenger vehicle operating expenses$/, "vehicle_expenses_other", $'$column') } \
  { gsub(/^City bus and subway transportation$/, "bus_subway_transit", $'$column') } \
  { gsub(/^Taxi and other local and commuter transportation services$/, "taxis", $'$column') } \
  { gsub(/^Air transportation$/, "air_transit", $'$column') } \
  { gsub(/^Rail highway bus and other inter-city transportation$/, "inter-city_transit_other", $'$column') } \
  { gsub(/^Prescribed medicines \(excluding medicinal cannabis\)$/, "medicines_prescribed", $'$column') } \
  { gsub(/^Medicinal cannabis$/, "cannabis_medicinal", $'$column') } \
  { gsub(/^Non-prescribed medicines$/, "medicines_non-prescribed", $'$column') } \
  { gsub(/^Prescription eyeglasses$/, "eyeglasses", $'$column') } \
  { gsub(/^Contact lenses$/, "contact_lenses", $'$column') } \
  { gsub(/^Other eye care goods$/, "eye_goods_other", $'$column') } \
  { gsub(/^Other health care goods$/, "health_goods_other", $'$column') } \
  { gsub(/^Eye care services$/, "eye_services", $'$column') } \
  { gsub(/^Dental care services$/, "dental_services", $'$column') } \
  { gsub(/^Other health care services$/, "health_services_other", $'$column') } \
  { gsub(/^Personal soap$/, "soap", $'$column') } \
  { gsub(/^Creams lotions and cosmetics$/, "lotions", $'$column') } \
  { gsub(/^Perfume and cologne$/, "perfume", $'$column') } \
  { gsub(/^Hair preparations and other toilet preparations$/, "hair_prep", $'$column') } \
  { gsub(/^Oral-hygiene products$/, "oral_products", $'$column') } \
  { gsub(/^Other personal care supplies and equipment$/, "personal_care_goods_other", $'$column') } \
  { gsub(/^Personal care services$/, "personal_care_services", $'$column') } \
  { gsub(/^Sporting and exercise equipment$/, "sporting_equipment", $'$column') } \
  { gsub(/^Toys games \(excluding video games\) and hobby supplies$/, "toys", $'$column') } \
  { gsub(/^Computer equipment software and supplies$/, "computer_equipment", $'$column') } \
  { gsub(/^Multipurpose digital devices$/, "digital_devices", $'$column') } \
  { gsub(/^Photographic equipment and supplies$/, "photo_equipment", $'$column') } \
  { gsub(/^Other recreational equipment$/, "recreational_equipment_other", $'$column') } \
  { gsub(/^Recreational services$/, "recreational_services", $'$column') } \
  { gsub(/^Purchase of recreational vehicles and outboard motors$/, "recreational_vehicle_purchase", $'$column') } \
  { gsub(/^Fuel parts and accessories for recreational vehicles$/, "recreational_vehicle_accessories", $'$column') } \
  { gsub(/^Insurance licences and other services for recreational vehicles$/, "recreational_vehicle_insurance", $'$column') } \
  { gsub(/^Audio equipment$/, "audio_equipment", $'$column') } \
  { gsub(/^Video equipment$/, "video_equipment", $'$column') } \
  { gsub(/^Rental of digital media$/, "digital_media_rental", $'$column') } \
  { gsub(/^Purchase of digital media$/, "digital_media_purchase", $'$column') } \
  { gsub(/^Other home entertainment equipment parts and services$/, "home_entertainment_other", $'$column') } \
  { gsub(/^Traveller accommodation$/, "traveller_accommodation", $'$column') } \
  { gsub(/^Travel tours$/, "travel_tours", $'$column') } \
  { gsub(/^Spectator entertainment \(excluding video and audio subscription services\)$/, "spectator_entertainment", $'$column') } \
  { gsub(/^Video and audio subscription services$/, "video_and_audio_subscriptions", $'$column') } \
  { gsub(/^Use of recreational facilities and services$/, "recreational_facilities", $'$column') } \
  { gsub(/^Tuition fees$/, "tuition_fees", $'$column') } \
  { gsub(/^School textbooks and supplies$/, "school_supplies", $'$column') } \
  { gsub(/^Other lessons courses and education services$/, "education_services_other", $'$column') } \
  { gsub(/^Newspapers$/, "newspapers", $'$column') } \
  { gsub(/^Magazines and periodicals$/, "magazines", $'$column') } \
  { gsub(/^Books and other reading material \(excluding textbooks\)$/, "books", $'$column') } \
  { gsub(/^Recreational cannabis$/, "cannabis_recreational", $'$column') } \
  { gsub(/^Beer served in licensed establishments$/, "beer_served", $'$column') } \
  { gsub(/^Wine served in licensed establishments$/, "wine_served", $'$column') } \
  { gsub(/^Liquor served in licensed establishments$/, "liquor_served", $'$column') } \
  { gsub(/^Beer purchased from stores$/, "beer_purchased", $'$column') } \
  { gsub(/^Wine purchased from stores$/, "wine_purchased", $'$column') } \
  { gsub(/^Liquor purchased from stores$/, "liquor_purchased", $'$column') } \
  { gsub(/^Cigarettes$/, "cigarettes", $'$column') } \
  { gsub(/^Other tobacco products and smokers\x27 supplies$/, "tobacco_other", $'$column') } \
  { gsub(/^All-items$/, "all_items", $'$column') } \
  { gsub(/^All other food preparations$/, "food_prep_all_other", $'$column') } \
  { gsub(/^Baby foods$/, "baby_foods", $'$column') } \
  { gsub(/^Fresh or frozen meat \(excluding poultry\)$/, "fresh_or_frozen_meat", $'$column') } \
  { gsub(/^Fresh or frozen poultry$/, "fresh_or_frozen_meat_poultry", $'$column') } \
  { gsub(/^Ham and bacon$/, "ham_and_bacon", $'$column') } \
  { gsub(/^Processed meat$/, "processed_meat", $'$column') } \
  { gsub(/^Meat$/, "meat", $'$column') } \
  { gsub(/^Canned and other preserved fish$/, "canned_fish", $'$column') } \
  { gsub(/^Fish$/, "fish", $'$column') } \
  { gsub(/^Seafood and other marine products$/, "seafood", $'$column') } \
  { gsub(/^Fish seafood and other marine products$/, "fish_and_seafood", $'$column') } \
  { gsub(/^Fresh milk$/, "milk", $'$column') } \
  { gsub(/^Cheese$/, "cheese", $'$column') } \
  { gsub(/^Dairy products$/, "dairy", $'$column') } \
  { gsub(/^Dairy products and eggs$/, "dairy_and_eggs", $'$column') } \
  { gsub(/^Cookies and crackers$/, "cookies_and_crackers", $'$column') } \
  { gsub(/^Bakery products$/, "bakery_products", $'$column') } \
  { gsub(/^Pasta products$/, "pasta_products", $'$column') } \
  { gsub(/^Cereal products \(excluding baby food\)$/, "cereal_products", $'$column') } \
  { gsub(/^Bakery and cereal products \(excluding baby food\)$/, "bakery_and_cereal_products", $'$column') } \
  { gsub(/^Fresh fruit$/, "fruit_fresh", $'$column') } \
  { gsub(/^Other preserved fruit and fruit preparations$/, "fruit_preserved_other", $'$column') } \
  { gsub(/^Preserved fruit and fruit preparations$/, "fruit_preserved", $'$column') } \
  { gsub(/^Fruit fruit preparations and nuts$/, "fruit", $'$column') } \
  { gsub(/^Fresh vegetables$/, "vegetables_fresh", $'$column') } \
  { gsub(/^Preserved vegetables and vegetable preparations$/, "vegetables_preserved", $'$column') } \
  { gsub(/^Vegetables and vegetable preparations$/, "vegetables", $'$column') } \
  { gsub(/^Sugar and confectionery$/, "sugar", $'$column') } \
  { gsub(/^Edible fats and oils$/, "fats_and_oils", $'$column') } \
  { gsub(/^Coffee$/, "coffee", $'$column') } \
  { gsub(/^Coffee and tea$/, "coffee_and_tea", $'$column') } \
  { gsub(/^Condiments spices and vinegars$/, "condiments", $'$column') } \
  { gsub(/^Other food preparations$/, "food_prep_other", $'$column') } \
  { gsub(/^Other food products and non-alcoholic beverages$/, "food_products_other", $'$column') } \
  { gsub(/^Food purchased from stores$/, "food_store_purchased", $'$column') } \
  { gsub(/^Food purchased from restaurants$/, "food_restaurant_purchased", $'$column') } \
  { gsub(/^Food$/, "food", $'$column') } \
  { gsub(/^Shelter$/, "shelter", $'$column') } \
  { gsub(/^Rented accommodation$/, "rented_accommodation", $'$column') } \
  { gsub(/^Owned accommodation$/, "owned_accommodation", $'$column') } \
  { gsub(/^Water fuel and electricity$/, "water_fuel_electricity", $'$column') } \
  { gsub(/^Household operations furnishings and equipment$/, "household_furnishings_equipment", $'$column') } \
  { gsub(/^Household operations$/, "household_operations", $'$column') } \
  { gsub(/^Communications$/, "communications", $'$column') } \
  { gsub(/^Child care and housekeeping services$/, "child_care_and_housekeeping", $'$column') } \
  { gsub(/^Household cleaning products$/, "cleaning_products", $'$column') } \
  { gsub(/^Detergents and soaps \(other than personal care\)$/, "detergents_and_soaps", $'$column') } \
  { gsub(/^Other household cleaning products$/, "cleaning_products_other", $'$column') } \
  { gsub(/^Paper plastic and aluminum foil supplies$/, "paper_plastic_aluminum_supplies", $'$column') } \
  { gsub(/^Paper supplies$/, "paper_supplies", $'$column') } \
  { gsub(/^Plastic and aluminum foil supplies$/, "plastic_and_aluminum_supplies", $'$column') } \
  { gsub(/^Other household goods and services$/, "household_goods_services_other", $'$column') } \
  { gsub(/^Household furnishings and equipment$/, "furnishings_and_equipment", $'$column') } \
  { gsub(/^Furniture and household textiles$/, "furniture_textiles", $'$column') } \
  { gsub(/^Furniture$/, "furniture", $'$column') } \
  { gsub(/^Household textiles$/, "textiles", $'$column') } \
  { gsub(/^Household equipment$/, "equipment", $'$column') } \
  { gsub(/^Household appliances$/, "appliances", $'$column') } \
  { gsub(/^Tools and other household equipment$/, "tools_other", $'$column') } \
  { gsub(/^Clothing and footwear$/, "clothing_and_footwear", $'$column') } \
  { gsub(/^Clothing$/, "clothing", $'$column') } \
  { gsub(/^Footwear$/, "footwear", $'$column') } \
  { gsub(/^Clothing accessories watches and jewellery$/, "clothing_accessories", $'$column') } \
  { gsub(/^Clothing material notions and services$/, "clothing_material_and_services", $'$column') } \
  { gsub(/^Transportation$/, "transportation", $'$column') } \
  { gsub(/^Private transportation$/, "private_transit", $'$column') } \
  { gsub(/^Purchase leasing and rental of passenger vehicles$/, "passenger_vehicle_purchase_lease_rental", $'$column') } \
  { gsub(/^Purchase and leasing of passenger vehicles$/, "passenger_vehicle_purchase_lease", $'$column') } \
  { gsub(/^Purchase of passenger vehicles$/, "passenger_vehicle_purchase", $'$column') } \
  { gsub(/^Operation of passenger vehicles$/, "passenger_vehicle_operation", $'$column') } \
  { gsub(/^Passenger vehicle parts maintenance and repairs$/, "passenger_vehicle_repairs", $'$column') } \
  { gsub(/^Other passenger vehicle operating expenses$/, "passenger_vehicle_expenses_other", $'$column') } \
  { gsub(/^Public transportation$/, "public_transit", $'$column') } \
  { gsub(/^Local and commuter transportation$/, "local_transit", $'$column') } \
  { gsub(/^Inter-city transportation$/, "inter-city_transit", $'$column') } \
  { gsub(/^Health and personal care$/, "health_personal_care", $'$column') } \
  { gsub(/^Health care$/, "health_care", $'$column') } \
  { gsub(/^Health care goods$/, "health_care_goods", $'$column') } \
  { gsub(/^Medicinal and pharmaceutical products$/, "medicinal_products", $'$column') } \
  { gsub(/^Eye care goods$/, "eye_goods", $'$column') } \
  { gsub(/^Health care services$/, "health_care_services", $'$column') } \
  { gsub(/^Personal care$/, "personal_care", $'$column') } \
  { gsub(/^Personal care supplies and equipment$/, "personal_care_equipment", $'$column') } \
  { gsub(/^Toiletry items and cosmetics$/, "toiletry_items", $'$column') } \
  { gsub(/^Recreation education and reading$/, "recreation_education_reading", $'$column') } \
  { gsub(/^Recreation$/, "recreation", $'$column') } \
  { gsub(/^Recreational equipment and services \(excluding recreational vehicles\)$/, "recreation_equipment", $'$column') } \
  { gsub(/^Digital computing equipment and devices$/, "computing_equipment", $'$column') } \
  { gsub(/^Purchase and operation of recreational vehicles$/, "recreational_vehicle_purchase_operation", $'$column') } \
  { gsub(/^Operation of recreational vehicles$/, "recreational_vehicle_operation", $'$column') } \
  { gsub(/^Home entertainment equipment parts and services$/, "home_entertainment_equipment", $'$column') } \
  { gsub(/^Travel services$/, "travel_services", $'$column') } \
  { gsub(/^Other cultural and recreational services$/, "cultural_recreation_other", $'$column') } \
  { gsub(/^Education and reading$/, "education_and_reading", $'$column') } \
  { gsub(/^Education$/, "education", $'$column') } \
  { gsub(/^Reading material \(excluding textbooks\)$/, "reading_material", $'$column') } \
  { gsub(/^Alcoholic beverages tobacco products and recreational cannabis$/, "alcohol_tobacco_cannabis_recreational", $'$column') } \
  { gsub(/^Alcoholic beverages$/, "alcohol", $'$column') } \
  { gsub(/^Alcoholic beverages served in licensed establishments$/, "alcohol_restaurant_served", $'$column') } \
  { gsub(/^Alcoholic beverages purchased from stores$/, "alcohol_store_purchased", $'$column') } \
  { gsub(/^Tobacco products and smokers\x27 supplies$/, "tobacco", $'$column') }
  { gsub(/^All-items excluding food$/, "all_items_excl_food", $'$column') }
  { gsub(/^All-items excluding food and energy$/, "all_items_excl_food_and_energy", $'$column') }
  { gsub(/^All-items excluding mortgage interest cost$/, "all_items_excl_mortgage_interest", $'$column') }
  { gsub(/^All-items excluding alcoholic beverages tobacco products and smokers\x27 supplies and recreational cannabis$/, "all_items_excl_alcohol_tobacco_cannabis_recreational", $'$column') }
  { gsub(/^All-items excluding alcoholic beverages and recreational cannabis$/, "all_items_excl_alcohol_and_cannabis_recreational", $'$column') }
  { gsub(/^All-items excluding tobacco products and smokers\x27 supplies and recreational cannabis$/, "all_items_excl_tobacco_and_cannabis_recreational", $'$column') }
  { gsub(/^All-items excluding shelter$/, "all_items_excl_shelter", $'$column') }
  { gsub(/^All-items excluding energy$/, "all_items_excl_energy", $'$column') }
  { gsub(/^All-items excluding gasoline$/, "all_items_excl_gasoline", $'$column') }
  { gsub(/^All-items excluding shelter insurance and financial services$/, "all_items_excl_shelter_and_insurance_and_financial_services", $'$column') }
  { gsub(/^Private transportation excluding gasoline$/, "private_transit_excl_gasoline", $'$column') }
  { gsub(/^Food and energy$/, "food_and_energy", $'$column') }
  { gsub(/^Fresh fruit and vegetables$/, "fruit_fresh_and_vegetables_fresh", $'$column') }
  { gsub(/^Energy$/, "energy", $'$column') }
  { gsub(/^Housing \(1986 definition\)$/, "housing_1986_def", $'$column') }
  { gsub(/^Shelter \(1986 definition\)$/, "shelter_1986_def", $'$column') }
  { gsub(/^Goods and services$/, "goods_services", $'$column') }
  { gsub(/^Goods$/, "goods", $'$column') }
  { gsub(/^Durable goods$/, "goods_durable", $'$column') }
  { gsub(/^Semi-durable goods$/, "good_semi_durable", $'$column') }
  { gsub(/^Non-durable goods$/, "goods_non_durable", $'$column') }
  { gsub(/^Non-durable goods excluding food purchased from stores$/, "goods_non_durable_excl_food_store_purchased", $'$column') }
  { gsub(/^Non-durable goods excluding food purchased from stores and energy$/, "goods_non_durable_excl_food_store_purchased_and_energy", $'$column') }
  { gsub(/^Goods excluding food purchased from stores$/, "goods_excl_food_store_purchased", $'$column') }
  { gsub(/^Goods excluding food purchased from stores and energy$/, "goods_excl_food_store_purchased_and_energy", $'$column') }
  { gsub(/^Services$/, "services", $'$column') }
  { gsub(/^Services excluding shelter services$/, "services_excl_shelter_services", $'$column') }'
}
