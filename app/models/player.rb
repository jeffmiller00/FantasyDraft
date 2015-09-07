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

  def self.find_from_array player_arry
    player_info = Player.parse_player(player_arry[0])
    player_info[:position] = Position.find_by_abbrev player_arry[0].split(' ').last.strip
    player_info[:team] = player_arry[1].strip
    Player.find_player(player_info).first
  end

  def self.get_external_data source_url
    all = []

    doc = Nokogiri::HTML(open(source_url))
    full_txt = doc.xpath('//tbody').first
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
        
        player_info = Player.parse_player(player[0])
        player_info[:position] = Position.find_by_abbrev player[0].split(' ').last.strip
        player_info[:team] = player[1].strip
        player = Player.find_player(player_info)

        if player.empty?
          Player.create!(first_name: player_info[:first_name], last_name: player_info[:last_name], team: player_info[:team], position: player_info[:position])
        end
      end
    end

    Ranking.populate
    Player.all
  end

  def self.clear_picks!
    Player.all.each do |p|
      next if !p.picked?
      p.unpick!
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
    player_arry = player_string.split(' ')[1..2]

    player_hash[:first_name] = player_arry.first.strip
    player_hash[:last_name]  = player_arry.last.strip
    player_hash
  end

  def self.find_player(player_hash)
    Player.where('last_name' => player_hash[:last_name], 'team' => player_hash[:team], 'position' => player_hash[:position]) ||
      Player.where('first_name' => player_hash[:first_name], 'last_name' => player_hash[:last_name], 'team' => player_hash[:team])
  end
end
