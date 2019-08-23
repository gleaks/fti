SEED DUMP ORDER

rails db:seed:dump MODELS="Category,Customer,Location,Vendor" EXCLUDE="" APPEND=true
rails db:seed:dump MODELS="Part,Assembly,Product,User,Order" EXCLUDE="" APPEND=true
rails db:seed:dump MODELS="AssemblyBom,Modulelog,OrderBom,ProductBom,Stock,Vendorpart" EXCLUDE="" APPEND=true
rails db:seed:dump MODELS="Comment" EXCLUDE="" APPEND=true

HEROKU DB RESET
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:schema:load
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:seed

POSTGRESQL INDEX RESET
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
