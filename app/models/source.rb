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
        player_hash   = simple_espn_parse(player_ary)
        player_hash ||= complex_espn_parse(player_ary)
      else
        player_hash   = pm_parse(player_ary)
      end
      all_players << player_hash
    end

    all_players
  end

  protected

  def simple_espn_parse array
    return unless array.size <= 3

    player_hash = {}
    player_hash[:rank], player_hash[:first_name], player_hash[:last_name] = set_rank_name array[0]
    player_hash[:position]  = set_position array[1]
    if player_hash[:position].nil? || !player_hash[:position].is_a?(Position)
      player_hash[:position]  = set_position array[2]
      player_hash[:team]  = array[1]
    else
      player_hash[:team]  = array[2]
    end
    player_hash[:team] ||= 'JEFF'
    player_hash
  end

  def pm_parse array
    player_hash = {}
    player_hash[:rank], player_hash[:first_name], player_hash[:last_name] = set_rank_name "#{array[0]} #{array[1]}"
    player_hash[:position]  = set_position array[2]
    player_hash[:team] = array[3]
    player_hash[:team] = 'DEFENSE' if player_hash[:team].blank?
    player_hash
  end

  def complex_espn_parse array
    return unless array.size > 3

    player_hash = {}
    player_hash[:rank], player_hash[:first_name], player_hash[:last_name] = set_rank_name array[0]
    player_hash[:position]  = set_position array[3]
    player_hash[:team]  = array[1]
    player_hash[:team] ||= 'JEFF'
    player_hash
  end

  def set_rank_name string
    names = string.split(' ')

    return [names[0].strip.to_i, names[1].strip, names[2].strip]
  end

  def set_position string
    return if string.nil?
    pos = string.split(' ').last.gsub(/\d/, '').strip
    pos = 'DST' if pos.include?('D/ST') || pos.include?('DEF')
    Position.find_by_abbrev(pos)
  end

  def set_team string
  end

  def   parse_data full_txt
    all = full_txt.search('tr').map { |tr| tr.search('td').map { |td| td.text.strip } }

    while all[0].empty? do
      all.shift
    end
    all
  end

  def espn?
    !!(self.url.include? 'espn.com')
  end

  def pm?
    !!(self.url.include? 'predictionmachine.com')
  end
end