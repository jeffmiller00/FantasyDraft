class Source < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :url, uniqueness: true
  validates :weight, numericality: true
  validates :xpath, presence: true

  def fetch
    all_array = []
    doc = Nokogiri::HTML(open(self.url))
    full_txt = doc.xpath(self.xpath).first
    all_array = parse_espn_data full_txt if self.espn?
    all_hash = self.array_to_hash all_array

    all_hash
  end

  def array_to_hash array
    all_players = []

    # Need to add all these players to an array of hashes.
    array.each do |player_ary|
      player_hash   = simple_parse(player_ary)
      player_hash ||= complex_parse(player_ary)
      all_players << player_hash
    end

    all_players
  end

  protected

  def simple_parse array
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
binding.pry if(player_hash[:position].nil? || !player_hash[:position].is_a?(Position))
    player_hash
  end

  def complex_parse array
    return unless array.size > 3

    player_hash = {}
    player_hash[:rank], player_hash[:first_name], player_hash[:last_name] = set_rank_name array[0]
    player_hash[:position]  = set_position array[3]
    player_hash[:team]  = array[1]
    player_hash[:team] ||= 'JEFF'
binding.pry if(player_hash[:position].nil? || !player_hash[:position].is_a?(Position))
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

  def   parse_espn_data full_txt
    all = full_txt.search('tr').map { |tr| tr.search('td').map { |td| td.text.strip } }

    while all[0].empty? do
      all.shift
    end
    all
  end

  def espn?
    !!(self.url.include? 'espn.com')
  end
end