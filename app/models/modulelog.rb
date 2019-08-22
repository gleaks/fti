class Modulelog < ApplicationRecord
  acts_as_commentable
  belongs_to :order
  belongs_to :category
  belongs_to :assembly
  belongs_to :user

  def name
    serial.to_s + ' - ' + category.name
  end
end
