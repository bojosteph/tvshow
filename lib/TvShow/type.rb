
class TvShow::Type
  include Initialize
  extend Findable

  attr_accessor :show, :name, :genre 

  @@all = []
  
  def self.all
    @@all
  end

  def self.find_by_name(name)
    self.all.select { |type| type.name == name }
  end

  def self.create_from_show_hash
    TvShow::Show.all.collect do |show|
    type = TvShow::Type.new
      type.show = show.name
      type.name = show.type
      type.genre = show.genres
    end
  end
    
end


  
     
  