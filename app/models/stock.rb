class Stock < ApplicationRecord
  belongs_to :part
  belongs_to :location
end
