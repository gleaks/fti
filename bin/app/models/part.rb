class Part < ApplicationRecord
  belongs_to :category
  
  has_many :assembly_boms, dependent: :delete_all
  has_many :assemblies, through: :assembly_boms
end
