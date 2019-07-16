Assembly.find_each do |foo|
  a = foo.shortname.tr('0-9', '')
  b = a.tr(' ', '')
  c = b.tr('.', '')
  foo.shortname = c
  if foo.save
    puts "#{foo.id} saved"
  else
    puts foo.errors.full_messages
  end
end
