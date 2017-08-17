require 'open-uri'

class Player < ActiveRecord::Base
  include Clear
  belongs_to :position

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :position, presence: true
  validates :team, presence: true


  def self.parse_player_pos raw_pos
    return if raw_pos.nil?
    pos = raw_pos.split(' ').last.gsub(/\d/, '').strip
    pos = 'DST' if pos.include?('D/ST') || pos.include?('DEF')
    Position.find_by_abbrev(pos)
  end

  def self.populate
    Source.all.each do |source|
      all_players = source.fetch

      all_players.each do |player|
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
    player_arry = player_string.gsub(/,/,'').split(' ')[1..2]

    player_hash[:first_name] = player_arry.first.strip
    player_hash[:last_name]  = player_arry.last.strip
    player_hash
  end

  def self.find_player(player_hash)
    Player.where('last_name' => player_hash[:last_name], 'team' => player_hash[:team], 'position' => player_hash[:position]) ||
      Player.where('first_name' => player_hash[:first_name], 'last_name' => player_hash[:last_name], 'team' => player_hash[:team])
  end
end
