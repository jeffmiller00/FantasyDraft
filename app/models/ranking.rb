require 'open-uri'

class Ranking < ActiveRecord::Base
  include Clear
  belongs_to :source
  belongs_to :player

  validates :overall_rank, presence: true
  validates :pos_rank, presence: true

  def self.not_ranked? source, player, overall_rank
    results = Ranking.where('source_id' => source, 'player_id' => player, 'overall_rank' => overall_rank)
    return results.empty?
  end

  def self.fetch
    begin
      Source.all.each do |s| 
        all = []
        url = s.url

        doc = Nokogiri::HTML(open(url))
        full_txt = doc.xpath("//table")
        all = full_txt.search('tr').map { |tr| tr.search('td').map { |td| td.text.strip } }
        all.shift

        all.each do |rank| 
          player_info = Player.parse_player(rank[1])
          player_info[:pos] = Position.find_by_abbrev rank.last.tr('0-9','')
          player = Player.find_player(player_info)
          player = player.first

          if player.id && Ranking.not_ranked?(s, player, rank.first.to_i)
            Ranking.create(source: s, player: player, overall_rank: rank.first.to_i, pos_rank: rank.last.tr('a-zA-Z','').to_i)
          end
        end
      end
    rescue Exception => e
      print e, "\n"
    end
    Ranking.all
  end
end
