# require 'open-uri'

# Dose.delete_all if Rails.env.development?
# Ingredient.delete_all if Rails.env.development?
# Cocktail.delete_all if Rails.env.development?

# # INGREDIENT seed
# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# ingredients_serialized = open(url).read
# ingredients = JSON.parse(ingredients_serialized)

# ingredients["drinks"].each do |i|
#   Ingredient.create!(name: i["strIngredient1"])
# end

# 10.times do
#   url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
#   cocktail_serialized = open(url).read
#   cocktail = JSON.parse(cocktail_serialized)
#   Cocktail.create!(name: cocktail["drinks"][0]["strDrink"])
#   # cocktail_id = cocktail["drinks"][0]["idDrink"]
#   # dose_url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=#{cocktail_id}"
#   # dose_serialized = open(dose_url).read
#   # dose = JSON.parse(dose_serialized)
#   # Dose.create!(description: )
# end

require 'open-uri'

Dose.delete_all if Rails.env.development?
Ingredient.delete_all if Rails.env.development?
Cocktail.delete_all if Rails.env.development?

url = "https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json"

cocktails_array = JSON.parse(open(url).read)

cocktails_array.each do |cocktail|
  c = Cocktail.create!(name: cocktail["name"])
  p "Added #{c.name} to the list"
  cocktail["ingredients"].each do |ing|
    unless ing["ingredient"].nil?
      i = Ingredient.find_or_create_by!(name: ing["ingredient"])
      p "Added #{i.name} to the list"
      Dose.create(description: ing["amount"].to_s + " " + ing["unit"], ingredient: i, cocktail: c )
    end
  end
end

puts "you created #{Ingredient.count} ingredients"
puts "you created #{Cocktail.count} cocktails"
puts "you created #{Dose.count} doses"
