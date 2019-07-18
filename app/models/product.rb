class Product < ApplicationRecord
  belongs_to :category

  has_many :product_boms, dependent: :delete_all
  has_many :assemblies, through: :product_boms
  accepts_nested_attributes_for :product_boms, reject_if: :all_blank, allow_destroy: true

  has_many :order_boms, dependent: :delete_all
  has_many :orders, through: :order_boms
end
