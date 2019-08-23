class Modulelog < ApplicationRecord
  acts_as_commentable
  belongs_to :order
  belongs_to :category
  belongs_to :assembly
  belongs_to :user

  validates :user_id, :presence => true, :on => :update
  validates :order_id, :presence => true, :on => :update

  def name
    serial.to_s + ' - ' + category.name
  end
end
