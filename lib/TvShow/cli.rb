
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
      puts "To list name of CAST of a paticular SHOW , type 'cast'" .colorize(:cyan)
      line    
      puts "To list all of the  shows by genre, enter 'genre'.".colorize(:green)
      line
      puts "To list all of the shows by type, enter 'type'".colorize(:cyan)
      line
      puts "To list a particular episode type 'episode'".colorize(:green)
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
         search_show
      when "cast"
         show_cast
      when "type"
         list_type
      when "genre"
         list_genre
      when "episode"
         episode
      when "show type"
         find_by_type
      when "show genre"
         show_with_genre
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
    new_line
  end


  def search_show
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

  def show_cast
    list_show_by_rating
      reset_cast
       puts "Please enter number corresponding to show to list Cast Member"
       id = gets.strip
       puts "Cast Name".colorize(:green)
       TvShow::Cast.find_or_create_by_id(id)
        result = TvShow::Cast.all.each do |cast|
         puts cast.name.colorize(:yellow) 
      end
     print "Show NAME  :".colorize(:green)
     puts result[0].show
  end


  def list_type
    new_line
    TvShow::Type.all.each do |type| 
      line
       print"NAME:#{type.show}".ljust(42)
       print"TYPE:#{type.name}".ljust(35) +"\n"
    end
    new_line
  end
    
  def list_genre
    new_line
    TvShow::Genre.all.each do |genre|
      line
       print "NAME :#{genre.show}".ljust(42).colorize(:cyan)
       print "GENRE :#{genre.name}".gsub(/[^0-9A-Za-z]/," ").ljust(15) +"\n"
    end
    new_line
  end

  def list_by_name
    TvShow::Show.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
      line
      print "#{i}".colorize(:green).ljust(30)
      print "#{s.name}".ljust(45) + "\n"
   end
 end
    
  def episode
     list_by_name
      puts "WHICH TVSHOW DO YOU WANT TO KNOW".colorize(:green)
      puts "Please enter Show Number from Corresponding  Show List".colorize(:red)
     new_line

     input = gets.strip.to_i

     unless (1..TvShow::Show.all.length).include?(input)
       puts "ERROR Please input valid number !!!!!".colorize(:red)
     end  
       show = TvShow::Show.all.sort{ |a, b| a.name <=> b.name }[input - 1]
       line
        print"#{show.name}".colorize(:cyan).ljust(35)
        print "#{show.type}".colorize(:blue).center(10)
        print"#{show.genres}".gsub(/[^0-9A-Za-z]/," ").colorize(:red).rjust(30) +"\n" 
       new_line
        puts " #{show.summary}".gsub(/<.*?>/, " ").colorize(:green).rjust(19) +"\n"
       new_line 
   end

  
  def find_by_type
     list_type
      puts "Put Show Type as Listed".colorize(:green)
         
     input = $stdin.gets.chomp.capitalize

     show = TvShow::Type.find_by_name(input)
     new_line
     show.each do |type|
      line
      print "#{type.show}".colorize(:green).ljust(40)
      print "#{type.name}".rjust(30) +"\n"
   end
  new_line
 end
  

  def show_with_genre
    list_genre
     puts "Enter Genre to List Name of Shows ".colorize(:green)
    input = $stdin.gets.chomp.capitalize
    
     TvShow::Genre.all.each do |genre| 
      if genre.name.include?(input)
       line
       print "#{genre.show}".colorize(:cyan).ljust(40)
       print "#{genre.name}".gsub(/[^0-9A-Za-z]/," ").ljust(40) +"\n"
    end
  end
  new_line
end

private

  def line
    puts "-" * 90
  end

  def new_line
    puts "*" * 90
  end

  def reset_cast
    TvShow::Cast.clear 
  end

  def reset_search
    TvShow::Search.clear
  end

   
end

