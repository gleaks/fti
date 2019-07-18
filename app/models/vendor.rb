class Vendor < ApplicationRecord
  has_many :vendorparts, dependent: :delete_all
end
