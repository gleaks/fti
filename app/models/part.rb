class Part < ApplicationRecord
  belongs_to :category

  has_many :assembly_boms, dependent: :delete_all
  has_many :assemblies, through: :assembly_boms

  has_many :stocks, dependent: :delete_all
  has_many :locations, through: :stocks

  has_many :vendorparts, dependent: :delete_all
  has_many :vendors, through: :vendorparts

  def totalsum
    sum = 0
    assembly_boms.each do |ab|
      if ab.assembly.active == true && ab.assembly.current == true
        ab.count = 0 if ab.count.nil?
        sum += ab.count
      end
    end
    return sum
  end

  def assemblysum
    sum = 0
    assembly_boms.each do |ab|
      if ab.assembly.active == true && ab.assembly.current == true
        sum += 1
      end
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
