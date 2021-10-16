require 'rails_helper'

describe Movie do
    it 'should find movies with the same director' do
        movie1 = Movie.create(title: 'Test1', director: 'Director 1')
        movie2 = Movie.create(title: 'Test2', director: 'Director 1')
        results = Movie.similar_movies(movie1.id)
        expect(results).to eq([movie1, movie2])
    end
    
    it 'should return nil when no director present ' do
        movie1 = Movie.create(title: 'Test 1')
        results = Movie.similar_movies(movie1.id)
        expect(results).to eq(nil)
    end
end