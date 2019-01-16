
class TvShow::CastMember
  include Initialize
  extend Findable
  
  attr_accessor :show_name, :name, :gender, :show_id

  @@all = []
  
    
  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end

  def self.find_by_show_id(show_id)
    # return an array of characters matching this show's id
    self.all.detect { |cast| cast.show_id == show_id }    
  end
  
  def self.find_or_create_by_show_id(show_id)
    # return the existing array of characters if there are any that match the show_id
    # otherwise hit the api and create them and return them
    self.find_by_show_id(show_id) || self.create_cast_for_show_id(show_id)
  end

  def self.create_cast_for_show_id(show_id)
    # return an array of cast members corresponding to the show_id  
    show_hash = TvShow::TVAPI.get_cast(show_id)
    show_hash["_embedded"]["cast"].each do |show_cast|
      cast_member = TvShow::CastMember.new
      cast_member.show_name = show_hash["name"]
      cast_member.show_id = show_hash["id"]
      cast_member.name = show_cast["person"]["name"]
      cast_member.gender = show_cast["person"]["gender"]
    end
  end
      
  
end


