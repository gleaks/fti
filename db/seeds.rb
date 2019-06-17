# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'parts - sanitized.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   t = Part.new
#   t.id = row['id']
#   t.description = row['description']
#   t.mfg = row['mfg']
#   t.mfg_id = row['mfg_id']
#   t.category_id = row['category_id']
#   t.save
# end
# puts "There are now #{Part.count} rows in the transactions table"

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'ac11 - sanitized.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   t = AssemblyBom.new
#   t.assembly_id = row['assembly_id']
#   t.part_id = row['part_id']
#   t.refdes = row['refdes']
#   t.count = row['count']
#   t.save
# end
# puts "There are now #{AssemblyBom.count} rows in the transactions table"

csv_text = File.read(Rails.root.join('lib', 'seeds', 'assemblyboms - sanitized.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = AssemblyBom.new
  t.assembly_id = row['assembly_id']
  t.part_id = row['part_id']
  t.refdes = row['refdes']
  t.count = row['count']
  t.save
end
puts "There are now #{AssemblyBom.count} rows in the transactions table"