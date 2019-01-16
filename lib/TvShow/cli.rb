
class TvShow::CLI
    
  def call
    TvShow::Show.create_from_hash
    TvShow::Genre.create_from_show_hash
    TvShow::Type.create_from_show_hash
    introduction
    get_input
  end

  def introduction
    new_line
    new_line
    puts"<<< WELCOME TO TVSHOW GUIDE >>>".colorize(:cyan).center(90) + "\n"
    puts"THIS IS AN INTERACTIVE GUIDE TO HELP YOU FIND TV SHOW INFO.".colorize(:green).center(90) + "\n"
  end

  def get_input
    input = ""
    while input != "exit" 
      line
      puts "To list popular SHOWS sorted by rating , enter 'list'.".colorize(:cyan)
      line
      puts "To do a search of TVMAZE by KEYWORD enter 'search'".colorize(:green)
      line
      puts "To list Show summary, type 'info'" .colorize(:cyan)
      line    
      puts "To list all of the  shows by genre, enter 'genre'.".colorize(:green)
      line
      puts "To list all of the shows by type, enter 'type'".colorize(:cyan)
      line
      puts "To Find list Cast Member of a partcular Show. Type 'cast'".colorize(:green)
      line
      puts "To list all shows with particular type input 'show type'".colorize(:cyan)
      line
      puts "To list all shows with particular genre type 'show genre'".colorize(:green)
      line
      puts "To quit, type 'exit'.".colorize(:cyan)
      line
      puts "What would you like to do?".colorize(:green)
      print "> " .colorize(:red)
      
      input = gets.strip

      case input
      when "list"
         list_show_by_rating
      when "search"
         search_api_by_keyword
      when "info"
         list_show_info_with_show_name
      when "type"
         list_show_by_type
      when "genre"
         list_show_by_genre
      when "cast"
         list_show_cast_members_by_show_id
      when "show type"
         sort_same_show_by_type
      when "show genre"
         sort_same_show_by_genre
      end
    end
  end
      
  def list_show_by_rating
    new_line
    result = TvShow::Show.all.sort_by{|a| a.rating || 0}.reverse
    result.each do |show|
      line
      print "#{show.id}".colorize(:green).ljust(30)
      print "#{show.name}".ljust(30)
      print "#{show.rating}".colorize(:cyan).rjust(30) + "\n"
    end
  end

  def search_api_by_keyword
    reset_search
    puts "Please enter KEYWORD"
    input = gets.strip
    TvShow::Search.create(input)
    TvShow::Search.all.each do |show|
      line
      puts "Show ID : #{show.id}".colorize(:green).ljust(40)
      puts "NAME: #{show.name}".colorize(:cyan).ljust(40)
      puts "TYPE: #{show.type}".colorize(:green).ljust(40)
      puts "GENRE: #{show.genres}".gsub(/[^0-9A-Za-z]/," ").colorize(:cyan).ljust(40)
      puts "SUMMARY #{show.summary}".gsub(/<.*?>/, " ").colorize(:green).rjust(30)
    end
  end

  def list_show_info_with_show_name
    list_show_by_rating
    puts "Please enter Show Name corresponding to show list For Show Info like 'Dads'".colorize(:yellow)
    name = gets.strip
    begin
      result = TvShow::Show.find_by_name(name)
      puts result.name.colorize(:yellow) 
      puts result.type.colorize(:blue)
      puts "#{result.genres}".gsub(/[^0-9A-Za-z]/," ").colorize(:cyan)
      puts "#{result.summary}".gsub(/<.*?>/, " ").colorize(:green)
    rescue
      puts "Please put valid Name or Type as Listed"
      return
    end
  end

  def list_show_by_type
    new_line
    TvShow::Type.all.each do |type| 
      line
      print"NAME:#{type.show}".ljust(42)
      print"TYPE:#{type.name}".ljust(35) +"\n"
    end
  end
    
  def list_show_by_genre
    new_line
    TvShow::Genre.all.each do |genre|
      line
      print "NAME :#{genre.show}".ljust(42).colorize(:cyan)
      print "GENRE :#{genre.name}".gsub(/[^0-9A-Za-z]/," ").ljust(15) +"\n"
    end
  end

  def list_show_by_name
    TvShow::Show.all.each do |s|
      line
      print "#{s.id}".colorize(:green).ljust(30)
      print "#{s.name}".ljust(45) + "\n"
    end
  end
    
  def list_show_cast_members_by_show_id
    list_show_by_name
    puts "WHICH TVSHOW DO YOU WANT TO KNOW".colorize(:green)
    puts "Please enter Show ID from Corresponding  Show List ".colorize(:red)

    id = gets.strip.to_i
    begin
      tv_show = TvShow::Show.new 
      tv_show.cast_members(id)
      TvShow::CastMember.all.select do |cast|
        if cast.show_id === id
        puts cast.name.colorize(:green)
        end
    rescue
        puts "Please Enter Valid Input"
        return
      end
    end
  end
    
   
  
  def sort_same_show_by_type
    list_show_by_type
    puts "Put Show Type as Listed".colorize(:green)

    input = $stdin.gets.chomp
    new_line
    show = TvShow::Type.find_by_name(input)

    show.each do |type|
      print "#{type.show}".colorize(:green).ljust(40)
      print "#{type.name}".rjust(30) +"\n"
    end
  end  

  def sort_same_show_by_genre
    list_show_by_genre
    puts "Enter Genre to List Name of Shows ".colorize(:green)
    input = $stdin.gets.chomp.capitalize
    
    TvShow::Genre.all.each do |genre| 
      if genre.name.include?(input)
        print "#{genre.show}".colorize(:cyan).ljust(40)
        print "#{genre.name}".gsub(/[^0-9A-Za-z]/," ").ljust(40) +"\n"
      end
    end
  end

private

  def line
    puts "-" * 90
  end

  def new_line
    puts "*" * 90
  end

  def reset_cast
    TvShow::CastMember.clear 
  end

  def reset_search
    TvShow::Search.clear
  end
   
end

