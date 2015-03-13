# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ambiances = ["Stylish", "Zen", "Design", "Classical", "Modern", "Art-deco", "Deluxe", "Boutique", "Romantic",
          "Nightlife", "Beach", "Mountain", "Golf", "Shopping", "Business", "Kid-friendly", "Entertaining",
          "Original", "Cosy", "Bright", "Gourmet", "Panoramic"]

ambiances.each do |ambience_item|
  ambience = Ambiance.create(text: ambience_item)
  ambience.save
end

facilities = ["Free wifi", "Indoor pool", "Outdoor pool", "Fitness", "Bar / Lounge", "Restaurant",
              "Room service", "Family rooms", "Babysitting", "Spa & Wellness", "Meeting facilities",
               "Express check-in/out", "Parking", "Garden", "Terrace", "Laundry & Dry cleaning", "Luggage storage",
            "Safety deposit box", "Shuttle", "Concierge", "Lift", "Disabled-friendly", "Pets allowed"]

facilities.each do |facility_item|
  facility = Facility.create(text: facility_item)
  facility.save
end

PriceCategory.create(name: "Budget", value: 40).save
PriceCategory.create(name: "Economy", value: 60).save
PriceCategory.create(name: "Moderate", value: 80).save
PriceCategory.create(name: "Premium", value: 100).save
