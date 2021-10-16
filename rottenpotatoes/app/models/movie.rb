class Movie < ActiveRecord::Base
    def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.similar_movies movie_id
    director = Movie.find_by(id: movie_id).director
    return nil if director.blank? or director.nil?
    Movie.where(director: director).all
  end
end
