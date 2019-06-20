class Modulelog < ApplicationRecord
  belongs_to :order
  belongs_to :category
  belongs_to :assembly
end
