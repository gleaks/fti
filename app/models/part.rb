class Part < ApplicationRecord
  belongs_to :category

  has_many :assembly_boms, dependent: :delete_all
  has_many :assemblies, through: :assembly_boms

  def totalsum
    sum = 0
    assembly_boms.each do |ab|
      ab.count = 0 if ab.count.nil?
      sum += ab.count
    end
    return sum
  end

  def active
    if totalsum < 1
      return false
    else
      return true
    end
  end
end
