 class TvShow::TVAPI
  include Initialize
  
  def self.get_shows
    url = 'http://api.tvmaze.com/shows'
    HTTParty.get(url).parsed_response
  end 

  def self.get_cast(id)
      query = (id + "?embed=cast")
      url = "http://api.tvmaze.com/shows/" + query
      HTTParty.get(url).parsed_response
  end

  def self.get_query(input)
     url = "http://api.tvmaze.com/search/shows?q=" + input
    HTTParty.get(url).parsed_response
  end

 end