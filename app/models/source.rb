class Source < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :url, uniqueness: true
  validates :weight, numericality: true
  validates :site, presence: true

  def self.go
    Source.create(name: 'Matthew Berry', 
                  url: 'http://espn.go.com/fantasy/football/story/_/page/NFLDK2K13_Berry_200/matthew-berry-top-200-overall-fantasy-football-rankings-2013', 
                  weight: 45, 
                  site: 'ESPN')
    Source.create(name: 'Christopher Harris', 
                  url: 'http://espn.go.com/fantasy/football/story/_/page/NFLDK2K13_Harris_200/christopher-harris-top-200-overall-fantasy-football-rankings-2013', 
                  weight: 35, 
                  site: 'ESPN')
    Source.create(name: 'Eric Karabell', 
                  url: 'http://espn.go.com/fantasy/football/story/_/page/NFLDK2K13_Karabell_200/eric-karabell-top-200-overall-fantasy-football-rankings-2013', 
                  weight: 2, 
                  site: 'ESPN')
  end
end
