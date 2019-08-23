class Team

  TEAMS = [
    {abbrev: 'BUF', name: 'Bills', market: 'Buffalo'},
    {abbrev: 'MIA', name: 'Dolphins', market: 'Miami'},
    {abbrev: 'NYJ', name: 'Jets', market: 'New York'},
    {abbrev: 'NE', name: 'Patriots', market: 'New England'},
    {abbrev: 'CIN', name: 'Bengals', market: 'Cincinnati'},
    {abbrev: 'CLE', name: 'Browns', market: 'Cleveland'},
    {abbrev: 'BAL', name: 'Ravens', market: 'Baltimore'},
    {abbrev: 'PIT', name: 'Steelers', market: 'Pittsburgh'},
    {abbrev: 'IND', name: 'Colts', market: 'Indianapolis'},
    {abbrev: 'JAC', name: 'Jaguars', market: 'Jacksonville'},
    {abbrev: 'HOU', name: 'Texans', market: 'Houston'},
    {abbrev: 'TEN', name: 'Titans', market: 'Tennessee'},
    {abbrev: 'DEN', name: 'Broncos', market: 'Denver'},
    {abbrev: 'LAC', name: 'Chargers', market: 'San Diego'},
    {abbrev: 'KC', name: 'Chiefs', market: 'Kansas City'},
    {abbrev: 'OAK', name: 'Raiders', market: 'Oakland'},
    {abbrev: 'DAL', name: 'Cowboys', market: 'Dallas'},
    {abbrev: 'PHI', name: 'Eagles', market: 'Philadelphia'},
    {abbrev: 'NYG', name: 'Giants', market: 'New York'},
    {abbrev: 'WAS', name: 'Redskins', market: 'Washington'},
    {abbrev: 'CHI', name: 'Bears', market: 'Chicago'},
    {abbrev: 'DET', name: 'Lions', market: 'Detroit'},
    {abbrev: 'GB', name: 'Packers', market: 'Green Bay'},
    {abbrev: 'MIN', name: 'Vikings', market: 'Minnesota'},
    {abbrev: 'TB', name: 'Buccaneers', market: 'Tampa Bay'},
    {abbrev: 'ATL', name: 'Falcons', market: 'Atlanta'},
    {abbrev: 'CAR', name: 'Panthers', market: 'Carolina'},
    {abbrev: 'NO', name: 'Saints', market: 'New Orleans'},
    {abbrev: 'SF', name: '49ers', market: 'San Francisco'},
    {abbrev: 'ARI', name: 'Cardinals', market: 'Arizona'},
    {abbrev: 'LA', name: 'Rams', market: 'St. Louis'},
    {abbrev: 'SEA', name: 'Seahawks', market: 'Seattle'}].freeze


  def self.find_by_abbrev abbrev
    abbrev = 'JAC' if abbrev == 'JAX'
    abbrev = 'LA' if abbrev == 'LAR'
    team = TEAMS.find {|team| team[:abbrev] == abbrev}
    return 'UNKNOWN' if team.nil?
    team[:abbrev]
  end

  def self.find_by_nickname nickname
    team = TEAMS.find {|team| team[:name] == nickname}
    team[:abbrev] || 'None'
  end
end