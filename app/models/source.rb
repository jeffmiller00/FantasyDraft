class Source < ActiveRecord::Base
  #attr_accessor :name, :url, :weight, :site

  validates :name, uniqueness: true
  validates :url, uniqueness: true
  validates :weight, numericality: true
  validates :site, presence: true
end
