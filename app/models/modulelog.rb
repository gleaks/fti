class Modulelog < ApplicationRecord
  acts_as_commentable
  belongs_to :order, optional: true
  belongs_to :category
  belongs_to :assembly
  belongs_to :user, optional: true

  def name
    serial.to_s + ' - ' + category.name
  end
end
