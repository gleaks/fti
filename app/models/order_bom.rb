class OrderBom < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def extendedprice
    count * product.price
  end
end
