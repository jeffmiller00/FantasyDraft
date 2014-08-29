require 'open-uri'

class Player < ActiveRecord::Base
  include Clear
  belongs_to :position

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :position, presence: true
  validates :team, presence: true


  def self.find_from_string player_string, position = nil
    player_hash = Player.parse_player player_string
    Player.find_player player_hash
  end

  def build_from_string player_string, position = nil
    player_hash = Player.parse_player player_string
    self.first_name = player_hash[:first_name]
    self.last_name  = player_hash[:last_name]
    self.team       = player_hash[:team]
    self
  end

  def self.get_external_data source_url
    all = []

    doc = Nokogiri::HTML(open(source_url))
    full_txt = doc.xpath("//table")
    all = full_txt.search('tr').map { |tr| tr.search('td').map { |td| td.text.strip } }

    while all[0].empty? do
      all.shift
    end
    all
  end

  def self.populate
    Source.all.each do |s| 
      all_players = Player.get_external_data s.url

      all_players.each do |player| 
        next if player.empty?
        
        player_info = Player.parse_player(player[1])
        player_info[:position] = Position.find_by_abbrev player[2].tr('0-9','')
        player = Player.find_player(player_info)

        if player.empty?
          Player.create(first_name: player_info[:first_name], last_name: player_info[:last_name], team: player_info[:team], position: player_info[:position])
        end
      end
    end
    Ranking.populate
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

  def unpick!
    self.picked = false
    self.save
  end

  def picked?
    self.picked || false
  end

  def picked_recently?
    (self.picked && (self.updated_at < (Time.now - 60.seconds))) || false
  end

  private

  def self.parse_player player_string
    player_hash = {}
    player_hash[:first_name] = player_string.split(' ').first
    player_hash[:team]       = player_string.split(' ').last
    player_hash[:last_name]  = player_string.sub(player_hash[:first_name], '').sub(player_hash[:team], '').sub(',','').strip
    player_hash
  end

  def self.find_player(player_hash)
    Player.where('last_name' => player_hash[:last_name], 'team' => player_hash[:team], 'position' => player_hash[:position]) ||
      Player.where('first_name' => player_hash[:first_name], 'last_name' => player_hash[:last_name], 'team' => player_hash[:team])
  end
end
