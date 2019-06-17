class Category < ApplicationRecord
    has_many :parts
    has_many :assemblies
    has_many :products
    has_many :orders
end
