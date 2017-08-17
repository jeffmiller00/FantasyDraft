class Source < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :url, uniqueness: true
  validates :weight, numericality: true
  validates :xpath, presence: true

  def fetch
    all_array = []
    doc = Nokogiri::HTML(open(self.url))
    full_txt = doc.xpath(self.xpath).first
    all_array = parse_data full_txt
    all_hash = self.array_to_hash all_array

    all_hash
  end

  def array_to_hash array
    all_players = []

    # Need to add all these players to an array of hashes.
    array.each do |player_ary|
      if self.espn?
        player_hash   = espn_parse(player_ary)
      else
        player_hash   = nfl_parse(player_ary)
      end
      all_players << player_hash
    end

    all_players
  end

  protected

  def espn_parse array
    player_hash = {}
    player_hash[:raw] = array[0]

    player_hash[:first_name],
    player_hash[:last_name],
    player_hash[:position],
    player_hash[:team] = parse_raw player_hash[:raw]

    if self.name.include? 'Berry'
      player_hash[:rank] = array[3].to_i
    elsif self.name.include? 'Clay'
      player_hash[:rank] = array[4].to_i
    elsif self.name.include? 'Cockcroft'
      player_hash[:rank] = array[5].to_i
    elsif self.name.include? 'Karabell'
      player_hash[:rank] = array[6].to_i
    elsif self.name.include? 'Yates'
      player_hash[:rank] = array[7].to_i
    else
      binding.pry
    end
    player_hash
  end

  def nfl_parse array
    player_hash = {}
    player_hash[:rank], player_hash[:first_name], player_hash[:last_name] = set_rank_name "#{array[0]} #{array[1]}"
    player_hash[:position]  = set_position array[2]
    player_hash[:team] = array[3]
    player_hash[:team] = 'DEFENSE' if player_hash[:team].blank?
    player_hash
  end

#reload!; Player.populate

  def parse_raw string
    string_parts = string.strip.split(' ')

    string_parts.shift.strip # Remove the overall rank
    team  = string_parts.pop.strip
    pos   = set_position(string_parts.pop.strip)
    fname = string_parts.shift.strip
    lname = string_parts.shift.strip

    return [fname, lname, pos, team]
  end

  def set_position string
    return if string.nil?
    pos = string.gsub(/\W/, '').strip
    pos = 'DST' if pos.include?('D/ST') || pos.include?('DEF')
    Position.find_by_abbrev(pos)
  end

  def parse_data full_txt
    all = full_txt.search('tr').map { |tr| tr.search('td').map { |td| td.text.strip } }

    while all[0].empty? do
      all.shift
    end
    all
  end

  def espn?
    !!(self.url.include? 'espn.com')
  end

  def nfl?
    !!(self.url.include? 'nfl.com')
  end
end