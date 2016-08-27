require 'open-uri'

class Ranking < ActiveRecord::Base
  include Clear
  belongs_to :source
  belongs_to :player

  validates :overall_rank, presence: true
  #validates :pos_rank, presence: true

  def self.not_ranked? source, player
    results = Ranking.where(source: source,
                            player: player)
    return results.empty?
  end

  def self.populate
    Source.all.each do |source| 
      all_players = source.fetch

      all_players.each do |player|
        next if player.empty?

        found_player = Player.find_player(player).first

        if found_player && found_player.id && Ranking.not_ranked?(source, found_player)
          r = Ranking.create(source: source,
                             player: found_player,
                             overall_rank: player[:rank].to_i)
        end
      end
    end
    Ranking.all
  end

  def self.get_all_by_player
    @all_ranks = []
    @max ||= Ranking.maximum("overall_rank") || 255
    @tolerence = 0.1
    @default_rank ||= @max * (1+@tolerence)

    Player.all.each do |player|
      one_rank = {}
      one_rank[:player] = player

      player_ranks = {}
      ranks = Ranking.where("player_id = #{player.id}").all
      ranks.each do |rnk|
        player_ranks[rnk.source_id] = rnk.overall_rank
      end

      if player_ranks.size != Source.all.size
        Source.all.each do |s|
          player_ranks[s.id] = player_ranks[s.id] || @default_rank
        end
      end
      one_rank[:overall_rank] = 0
      player_ranks.each do |source_id, val|
        s = Source.find source_id
        one_rank[:overall_rank] = one_rank[:overall_rank] + ((s.weight.to_f/100.0) * val)
      end
      #one_rank[:overall_rank] = player_ranks.values.inject{ |sum, el| sum + el }.to_f / player_ranks.size
#require 'pry'; binding.pry if one_rank[:player].id == 4
      one_rank[:sources] = player_ranks
      @all_ranks << one_rank
    end
    @all_ranks.sort_by { |hsh| hsh[:overall_rank] }
  end
end
