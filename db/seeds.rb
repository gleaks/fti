require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'modulelog-sanitized.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Modulelog.new
  t.serial = row['serial']
  t.assembly_id = row['﻿assembly_id']
  t.category_id = row['category_id']
  t.version = row['version']
  t.notes = row['notes']
  t.date = row['date']
  t.order_id = 1
  if t.save
    puts "#{t.serial} saved"
  else
    puts "#{t.errors.full_messages} - #{row['﻿assembly_id']} - #{row['serial']} - #{row['category_id']}"
  end
end

puts "There are now #{Modulelog.count} rows in the table"
