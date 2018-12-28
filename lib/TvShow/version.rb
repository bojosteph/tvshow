module TvShow
	
  VERSION = "0.1.0"
end

module Initialize
    def initialize(attributes={})
    attributes.each {|key, value| self.send(("#{key}="), value)}
    self.class.all << self
  end
end

module Findable
  def find_by_name(name)
    self.all.detect { |object| object.name == name }
  end
end

