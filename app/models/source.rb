class Source < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :url, uniqueness: true
  validates :weight, numericality: true
  validates :site, presence: true
end
