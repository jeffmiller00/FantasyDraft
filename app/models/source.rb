require 'open-uri'

class Source < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :url, presence: true#, uniqueness: true
  validates :weight, numericality: true
  validates :xpath, presence: true

  def fetch url=nil
    all_array = []
    url = self.url if url.nil?
    doc = Nokogiri::HTML(open(url))
# binding.pry  # Source 1) Get to the list
    # xpath = '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]/table/tbody'

    full_txt = doc.xpath(self.xpath)
    # full_txt = full_txt[self.id - 4].css('div.player-row') if self.cbs?
    all_array = parse_data full_txt

    self.array_to_hash all_array
  end

  def array_to_hash array
    all_players = []
    # Need to add all these players to an array of hashes.
    array.each do |player_ary|
      begin
        if self.espn? || self.ffc?
          player_hash   = espn_parse(player_ary)
        elsif self.cbs?
          player_hash   = cbs_parse(player_ary)
        elsif self.nfl?
          player_hash   = nfl_parse(player_ary)
        elsif self.ringer?
          player_hash   = ringer_parse(player_ary)
        else
        end
      rescue
        next
      end
      all_players << player_hash
    end

    all_players
  end

  def cbs?
    !!(self.url.include? 'cbssports.com')
  end

  def espn?
    !!(self.url.include? 'espn.com')
  end

  def ffc?
    !!(self.url.include? 'fantasyfootballcalculator.com')
  end

  def nfl?
    !!(self.url.include? 'nfl.com')
  end

  def ringer?
    !!(self.url.include? 'ringer.com')
  end

  protected

  def cbs_parse array
    player_hash = {}
    player_hash[:rank] = array[0].to_i
    player_hash[:first_name] = array[1]
    player_hash[:last_name] = array[2]
    player_hash[:team] = Team.find_by_abbrev array[3].upcase
    player_hash[:position] ||= set_position array[4].strip
    player_hash[:position] ||= set_position 'DST' # This ensures KC def gets a position

    player_hash
  end

  def espn_parse array
    player_hash = {}
    player_hash[:rank] = array[0].split('.')[0].to_i
    array.shift if array[0].size < 4 && array[0].to_i == player_hash[:rank]
    array[0].sub!("#{player_hash[:rank]}.",'')
    array.shift if array[0].blank?
    array[0].strip!
    array.delete_at(0) if ['UP','DOWN'].include?(array[0])
    player_hash[:first_name], player_hash[:last_name] = parse_name array[0]
    array.delete_at(2) if array[2].to_i > 0
    if Team.find_by_abbrev(array[1]) == 'UNKNOWN'
      player_hash[:position] = set_position array[1]
      player_hash[:team] = Team.find_by_abbrev array[2]
    else
      binding.pry if array[0].nil? || array[1].nil? || array[2].nil? || array[1] == 'RB'
      player_hash[:team] = Team.find_by_abbrev array[1]
      player_hash[:position] = set_position array[2][0..2]
      player_hash[:position] = set_position array[2][0..1]
      player_hash[:position] ||= set_position 'DST'
    end
    binding.pry if anything_blank?(player_hash)

    player_hash
  end

  def nfl_parse array
    player_hash = {}
    player_hash[:rank] = array[0].to_i
    array[1].sub!(' NWT','')
    array[1].sub!(' View News','')
    array[1].sub!(' View Videos','')
    array[1].strip!
    if array[1].include?('DEF')
      player_hash[:position] = set_position 'DST'
      array[1].sub!(' DEF','')
      player_hash[:first_name], player_hash[:last_name] = parse_name array[1].strip
      player_hash[:team] = set_def_team [player_hash[:first_name], player_hash[:last_name]]
    else
      player_hash[:team] = Team.find_by_abbrev array[1][-3..].strip
      player_hash[:team] = Team.find_by_abbrev array[1][-2..].strip if ['NO', 'NE'].include?(player_hash[:team][-2..])
      array[1] = array[1].rpartition(" - #{player_hash[:team][0..1]}")[0]
      raise 'This player doesn\'t have a team' if array[1][-2..].nil?
      player_hash[:position] = set_position array[1][-2..].strip
      player_hash[:position] = set_position('K') if player_hash[:position].blank? && array[1].last == 'K'
      binding.pry if player_hash[:position].blank?
      player_hash[:first_name], player_hash[:last_name] = parse_name array[1].strip
    end

    player_hash
  end

  def ringer_parse array
    player_hash = {}
    player_hash[:rank] = array[0].to_i
    raise 'This player doesn\'t have a team' if array.last.nil?
    player_hash[:team] = Team.find_by_nickname array.last.strip
    player_hash[:position] = set_position array[-2].sub!(',','').strip
    player_hash[:first_name], player_hash[:last_name] = array[1..2].map{|n| n.strip.sub(',','')}

    # binding.pry if player_hash[:position].size > 2

    player_hash
  end


  def set_def_team team_arr
    case team_arr[0]
      when 'Chicago'
        team = 'CHI'
      when 'Kansas'
        team = 'KC'
      when 'Minnesota'
        team = 'MIN'
      when 'Houston'
        team = 'HOU'
      when 'Arizona'
        team = 'ARI'
      when 'Jacksonville'
        team = 'JAC'
      else
        team = 'NONE'
    end

    team
  end

  def parse_name string
    name_arry = string.strip.split(' ')
    [name_arry[0], name_arry[1]]
  end

  def set_position string
    return if string.nil?
    pos = string.gsub(/\W\d*/, '').strip
    pos = 'K' if pos == 'PK'
    pos = 'DST' if ['D/ST','DEF'].include?(pos)
    Position.find_by_abbrev(pos)
  end

  def parse_data full_txt
    all = []
# binding.pry  # Source 2) Parse the list to an array
    if self.nfl? || self.espn? || self.ffc?
      all = full_txt.search('tr').map { |tr| tr.search('td').map { |td| td.text.strip } }

      while all[0].empty? do
        all.shift
      end
    elsif self.ringer?
      all = full_txt.map { |td| td.text.strip.split(' ') }

      while all[0].include?('•') do
        all.shift
      end
    end

    all
  end

  private

  def anything_blank? player_hash
    return (player_hash[:rank].blank? || player_hash[:team].blank? ||
      player_hash[:position].blank? || player_hash[:first_name].blank? || player_hash[:last_name].blank?)
  end
end