# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
    { name: "Bayerische Motoren Werke AG", public_name: "BMW", pricing_policy: "prestige" },
    { name: "Audi AG", public_name: "Audi", pricing_policy: "flexible" },
    { name: "Volkswagen AG", public_name: "Volkswagen", pricing_policy: "fixed" }
].each do |org|
  Organization.create(org)
end

org = Organization.find_by_public_name("BMW")
models = (1..7).map { |i| { name: "Series #{i}" } }
org.models.create(models)

org.models.find("series-1").model_types.create(name: "M135i", base_price: 25000)
org.models.find("series-2").model_types.create([
                                                   { name: "Coupe", base_price: 28000 },
                                                   { name: "Convertible", base_price: 32000 },
                                                   { name: "Active Tourer", base_price: 36000 },
                                                   { name: "Gran Tourer", base_price: 40000 },
                                               ])

org = Organization.find_by_public_name("Audi")

%w{A Q}.each do |series|
  org.models.create(name: series)
end

model_types = (1..8).map { |i| { name: "Series #{i}", base_price: 28000 + i * 4000 } }
org.models.find("a").model_types.create(model_types)

model = Organization.find_by_public_name("Volkswagen").models.create(name: "Golf")
model.model_types.create([
                             { name: "Golf", base_price: "20000" },
                             { name: "GTI", base_price: "25000" },
                             { name: "R", base_price: "35000" },
                             { name: "e-Golf", base_price: 29000 }
                         ])

User.create(email: "user@aureso.com", password: "password")