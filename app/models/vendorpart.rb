class Vendorpart < ApplicationRecord
  belongs_to :vendor
  belongs_to :part
end
