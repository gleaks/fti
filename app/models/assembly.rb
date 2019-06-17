class Assembly < ApplicationRecord
  belongs_to :category
  
  has_many :assembly_boms, dependent: :delete_all
  has_many :parts, through: :assembly_boms
  accepts_nested_attributes_for :assembly_boms, reject_if: :all_blank, allow_destroy: true
  
  has_many :product_boms, dependent: :delete_all
  has_many :products, through: :product_boms
end
