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

1.upto(7) do |i|
  org.models.create(name: "Series #{i}")
end

org = Organization.find_by_public_name("Audi")

%w{A Q}.each do |series|
  org.models.create(name: series)
end

Organization.find_by_public_name("Volkswagen").models.create(name: "Golf")