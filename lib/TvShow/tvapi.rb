 class TvShow::TVAPI
  include Initialize
  
  def self.get_shows
    url = 'http://api.tvmaze.com/shows'
    HTTParty.get(url).parsed_response
  end 

  def self.get_cast(id)
  	if id.to_i <= 40000 
      query = (id + "?embed=cast")
      url = "http://api.tvmaze.com/shows/" + query
      data||=HTTParty.get(url).parsed_response
    else 
      puts "Input Valid number".colorize(:red)
      self.get_cast
   end
 end

  def self.get_query(input)
     url = "http://api.tvmaze.com/search/shows?q=" + input
    HTTParty.get(url).parsed_response
  end

 end