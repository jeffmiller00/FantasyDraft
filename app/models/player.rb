require 'open-uri'

class Player < ActiveRecord::Base
  include Clear
  belongs_to :position

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :position, presence: true
  validates :team, presence: true

  def self.find_player(player_hash)
    Player.where('last_name' => player_hash[:last], 'team' => player_hash[:team], 'position' => player_hash[:pos]) ||
      Player.where('first_name' => player_hash[:first], 'last_name' => player_hash[:last], 'team' => player_hash[:team])
  end

  def self.parse_player(player_string)
    ret_player = {}
    ret_player[:first] = player_string.split(' ').first
    ret_player[:team]  = player_string.split(' ').last
    ret_player[:last]  = player_string.sub(ret_player[:first], '').sub(ret_player[:team], '').sub(',','').strip
    ret_player
  end

  def self.fetch
    begin
      Source.all.each do |s| 
        all = []
        url = s.url

        doc = Nokogiri::HTML(open(url))
        full_txt = doc.xpath("//table")
        all = full_txt.search('tr').map { |tr| tr.search('td').map { |td| td.text.strip } }

        all.each do |player| 
          if player.empty?
            next
          end

          player_info = Player.parse_player(player[1])
          player_info[:pos] = Position.find_by_abbrev player.last.tr('0-9','')
          player = Player.find_player(player_info)

          if player.empty?
            Player.create(first_name: player_info[:first], last_name: player_info[:last], team: player_info[:team], position: player_info[:pos])
          end
        end
      end
    rescue Exception => e
      print e, "\n"
    end
    Ranking.fetch
    Player.all
  end

  def self.clear_picks!
    Player.all.each do |p|
      next if !p.picked?
      p.picked = false
      p.save
    end
  end

  def pick!
    self.picked = true
    self.save
  end

  def picked?
    self.picked || false
  end
end
