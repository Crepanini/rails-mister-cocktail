# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

Dose.delete_all if Rails.env.development?
Ingredient.delete_all if Rails.env.development?
Cocktail.delete_all if Rails.env.development?

# INGREDIENT seed
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)

ingredients["drinks"].each do |i|
  Ingredient.create!(name: i["strIngredient1"])
end

10.times do
  url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
  cocktail_serialized = open(url).read
  cocktail = JSON.parse(cocktail_serialized)
  Cocktail.create!(name: cocktail["drinks"][0]["strDrink"])
  # cocktail_id = cocktail["drinks"][0]["idDrink"]
  # dose_url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=#{cocktail_id}"
  # dose_serialized = open(dose_url).read
  # dose = JSON.parse(dose_serialized)
  # Dose.create!(description: )
end

puts "you created #{Ingredient.count} ingredients"
puts "you created #{Cocktail.count} cocktails"
