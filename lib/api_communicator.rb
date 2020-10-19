require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  films = []
   select_character(character_name)["films"].each do |film|
     film_string = RestClient.get(film)
     film_hash = JSON.parse(film_string)
     films << film_hash
   end
   films

end

def character_hashes
  response_string = RestClient.get('http://swapi.dev/api/people')
  response_hash = JSON.parse(response_string)
  characters = response_hash["results"].map {|character| character}
  characters
end

def select_character(character)
  character_hashes.select do |hash| 
    hash["name"] == character
  end.first
end

def print_movies(films)
  films.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
