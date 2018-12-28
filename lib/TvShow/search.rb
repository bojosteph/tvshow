class TvShow::Search
  include Initialize
  include Findable
  
  @@all = []
  attr_accessor :name, :type, :genres, :id, :summary
  
  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end
   
  def self.create(input)
     TvShow::TVAPI.get_query(input).each do |show_hash|
     search = TvShow::Search.new
     search.name = show_hash["show"]["name"]
     search.type = show_hash["show"]["type"]
     search.genres = show_hash["show"]["genres"]
     search.id = show_hash["show"]["id"]
     search.summary = show_hash["show"]["summary"]
   end
  end

end
