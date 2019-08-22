class Order < ApplicationRecord
  belongs_to :category
  belongs_to :customer

  has_many :order_boms, dependent: :delete_all
  has_many :products, through: :order_boms
  accepts_nested_attributes_for :order_boms, reject_if: :all_blank, allow_destroy: true

  has_many :modulelogs

  def subtotal
    a = 0
    order_boms.each do |bom|
      a += bom.extendedprice
    end
    return a
  end

  def discount
    subtotal * 0.2
  end

  def total
    subtotal - discount
  end

  def progress
    modulelogs.sum(:progress) / modulelogs.count
  end
end
