require 'open-uri'

class Player < ActiveRecord::Base
  belongs_to :position

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :position, presence: true
  validates :team, presence: true

  def self.fetch
    begin
      Source.all.each do |s| 
        all = []
        url = s.url

        doc = Nokogiri::HTML(open(url))
        full_txt = doc.xpath("//table")
        all = full_txt.search('tr').map { |tr| tr.search('td').map { |td| td.text.strip } }
        all.shift

        all.each do |player| 
          first = player[1].split(' ').first
          team  = player[1].split(' ').last
          last  = player[1].sub(first, '').sub(team, '').sub(',','').strip
          pos = Position.find_by_abbrev player.last.tr('0-9','')
          if (Player.where('first_name' => first, 'last_name' => last, 'team' => team ).empty? || 
              Player.where('last_name' => last, 'team' => team, 'position' => pos ).empty? )
            Player.create(first_name: first, last_name: last, team: team, position: pos)
          else
            puts '============================================================================'
            pp  Player
            puts '============================================================================'
          end
        end
        Player.all
      end
    rescue Exception => e
      print e, "\n"
    end
  end
end
