require 'json'

movie_data = JSON.parse(File.read('in_theaters.json')) 

pertinent_info = []

movie_data["movies"].each do |movie| 
	  while movie['abridged_cast'].count < 3
	  	movie['abridged_cast'] << ""
	  end
end

movie_data["movies"].each do |movie| 
	pertinent_info << {
	  title: movie['title'], rating: movie['mpaa_rating'], 
	  avg_score: ( (movie['ratings']['critics_score'] + movie['ratings']['critics_score']) / 2 ),
	  cast: [ movie['abridged_cast'][0]['name'], movie['abridged_cast'][1]['name'], movie['abridged_cast'][2]['name'] ]
	  }  
end

pertinent_info = pertinent_info.sort_by {|movie| -movie[:avg_score]}

puts "Movies in theaters now, sorted by average of critic and audience scores on Rotten Tomatoes:"
pertinent_info.each do |movie| 
	puts "#{movie[:title]} (#{movie[:rating]}) - Score: #{movie[:avg_score]}"
	if movie[:cast][2] != nil
		puts "Starring #{movie[:cast][0]}, #{movie[:cast][1]} and #{movie[:cast][2]}." 
	elsif movie[:cast][1] != nil
	  puts "Starring #{movie[:cast][0]} and #{movie[:cast][1]}." 
	else
	  puts "Starring #{movie[:cast][0]}."
	end
end

#movie_data =
#{ hash listing rotten tomatoes data with:
#  [ array of movies... containing:
#    { hashes of single movies ...with values including:
#       [ an array of cast members ...consisting of:
#        { hashes, you want the 'name' key's value 
# one_actor} actors] one_movie} movies] all_data}