
class TvShow::Genre
  include Initialize
  extend Findable
 
  attr_accessor :show, :type, :name

  @@all = []
 
  def self.all
    @@all
  end
    
  def self.create_from_show_hash
    TvShow::Show.all.collect do |show|
    genre = TvShow::Genre.new
      genre.show = show.name
      genre.type = show.type
      genre.name = show.genres
    end
  end
  
end
