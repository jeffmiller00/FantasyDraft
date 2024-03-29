require 'open-uri'

class Player < ActiveRecord::Base
  include Clear
  belongs_to :position

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :position, presence: true
  validates :team, presence: true

  after_validation :remove_suffix

  def self.populate
    Source.all.each do |source|
      add_players source.fetch
      add_players(source.fetch('http://fantasy.nfl.com/research/rankings?leagueId=0&statType=draftStats&offset=101')) if source.nfl?
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

  def self.add_players players_arry
    players_arry.each do |player|
      next if player.blank?

      found_player = Player.find_player(player)
      if found_player.empty?
        Player.create!(first_name: player[:first_name],
                       last_name:  player[:last_name],
                       team:       player[:team],
                       position:   player[:position])
      end
    end
  end

  def self.parse_player player_string
    player_hash = {}
    player_arry = player_string.gsub(/,/,'').split(' ')[1..2]

    player_hash[:first_name] = player_arry.first.strip
    player_hash[:last_name]  = player_arry.last.strip
    player_hash
  end

  def self.find_player(player_hash)
    sanitized_last_name = Player.remove_suffix(player_hash[:last_name])
    Player.where('last_name' => sanitized_last_name, 'team' => player_hash[:team], 'position' => player_hash[:position]) ||
      Player.where('first_name' => player_hash[:first_name], 'last_name' => sanitized_last_name, 'team' => player_hash[:team])
  end

  def self.remove_suffix last_name
    last_name = last_name.gsub(/jr[.]?$/i, '').strip
    last_name = last_name.gsub(/V$/i, '').strip
    last_name = last_name.gsub(/II$/i, '').strip
    last_name = last_name.gsub(/III$/i, '').strip
    last_name
  end

  def remove_suffix
    self.last_name = Player.remove_suffix(self.last_name)
  end
end
