# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

CSV.foreach('db/category2.csv') do |row|
  Category.find_or_create_by(id: row[0], name: row[1], ancestry: row[2])
end

CSV.foreach('db/size.csv') do |row|
  Size.find_or_create_by(id: row[0], name: row[1])
end


CSV.foreach('db/brand.csv') do |row|
  Brand.find_or_create_by(id: row[0], name: row[1])
end

#アイテム
#CSV.foreach('db/test.csv') do |row|
 # Item.create(id: row[0], name: row[1], price: row[2], describe: row[3], status: row[4], delivery_fee: row[5], region: row[6], transport_day: row[7], seller_id: row[8],buyer_id: row[9],category_id: row[10], brand_id: row[11], size_id: row[12])
#end

