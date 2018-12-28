
class TvShow::Cast
  include Initialize
  include Findable
  
  attr_accessor :show, :name, :gender, :id

  @@all = []
  
    
  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end

  def self.find_by_id(id)
    self.all.detect { |cast| cast.id == id }    
  end
  
  def self.find_or_create_by_id(id)
   self.find_by_id(id) || self.create(id)
  end

  def self.create(id)  
     show_hash = TvShow::TVAPI.get_cast(id)
     show_hash["_embedded"]["cast"].each do |show_cast|
     cast = TvShow::Cast.new
     cast.show = show_hash["name"]
     cast.id = show_hash["id"]
     cast.name = show_cast["person"]["name"]
     cast.gender = show_cast["person"]["gender"]
     cast
    end
  end
      
  
end


