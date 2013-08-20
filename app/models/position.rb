class Position < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :abbrev, uniqueness: true

  def self.go
    Position.create(name: 'Quarterback', abbrev: 'QB')
    Position.create(name: 'Running Back', abbrev: 'RB')
    Position.create(name: 'Wide Reciever', abbrev: 'WR')
    Position.create(name: 'Tight End', abbrev: 'TE')
    Position.create(name: 'Kicker', abbrev: 'K')
    Position.create(name: 'Defense & Special Teams', abbrev: 'DEF')
  end
end
