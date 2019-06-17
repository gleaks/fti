class ProductBom < ApplicationRecord
  belongs_to :assembly
  belongs_to :product
end
