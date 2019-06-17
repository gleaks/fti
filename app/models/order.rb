class Order < ApplicationRecord
  belongs_to :category
  belongs_to :customer
  
  has_many :order_boms
  has_many :products, through: :order_boms
  accepts_nested_attributes_for :order_boms, reject_if: :all_blank, allow_destroy: true
end
