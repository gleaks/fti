class Customer < ApplicationRecord
    has_many :orders, dependent: :delete_all
end
