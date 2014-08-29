class Position < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :abbrev, uniqueness: true
end
