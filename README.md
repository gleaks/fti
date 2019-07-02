SEED DUMP ORDER

rails db:seed:dump MODELS="Category,Customer,Location" EXCLUDE="" APPEND=true
rails db:seed:dump MODELS="Part,Assembly,Product,User,Order" EXCLUDE="" APPEND=true
rails db:seed:dump MODELS="AssemblyBom,Modulelog,OrderBom,ProductBom" EXCLUDE="" APPEND=true

HEROKU DB RESET
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:schema:load
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:seed