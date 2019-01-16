class TvShow::Show
  include Initialize
  extend Findable

  @@all = []
  attr_accessor :name, :type, :genres, :summary, :id, :rating
  
  def self.all
    @@all
  end
   
  def self.create_from_hash
    TvShow::TVAPI.get_shows.each do |show_hash|
    show = TvShow::Show.new
      show.name = show_hash["name"]
      show.type = show_hash["type"]
      show.genres = show_hash["genres"]
      show.summary = show_hash["summary"]
      show.id = show_hash["id"]
      show.rating = show_hash["rating"]["average"]
    end
  end 

  def self.sort
    self.all.sort_by{|a| a.rating || 0}.reverse
  end

  def cast_members(id) 
    TvShow::CastMember.find_or_create_by_show_id(id)
  end
 
end    


    
    
  

     















     








