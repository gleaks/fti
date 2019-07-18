class Category < ApplicationRecord
    has_many :parts, dependent: :delete_all
    has_many :assemblies, dependent: :delete_all
    has_many :products, dependent: :delete_all
    has_many :orders, dependent: :delete_all
    has_many :modulelogs, dependent: :delete_all
end
