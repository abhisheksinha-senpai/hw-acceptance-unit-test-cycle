require 'rails_helper'

describe MoviesController do
    describe 'get show' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-12') }
        before(:each) do
            get :show, id: movie.id
        end
        it 'should display the show.html.erb template' do
            expect(response).to render_template('show')
        end
        it 'should populate the movie' do
            expect(assigns(:movie)).to eql(movie)
        end
    end
    
    describe 'homepage' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-01') }
        before(:each) do
            get :index
        end
        it 'should display the index.html.erb template' do
            expect(response).to render_template('index')
        end
    end
    describe 'similar movies' do
        let!(:movie1) { Movie.create!(title: 'Title1', director: 'Director1') }
        let!(:movie2) { Movie.create!(title: 'Title2', director: 'Director1') }
        
        it 'should display in find_similar_movies.html template' do
            get :find_similar_movies, id: movie1.id
            expect(response).to render_template('find_similar_movies')
        end
    end
    
    describe 'new action' do
        let!(:movie) { Movie.new }
        it 'should display in the new.html template' do
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe 'create' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-23') }
        it 'creates a new movie' do
            post :create, movie: movie.attributes()
            expect(Movie.count).to eq(2)
        end
    end

    describe 'edit' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-23') }
        it 'should find the movie\'s edit page' do
            get :edit, id: movie.id
            expect(assigns(:movie)).to eql(movie)
        end
    end
    
    describe 'update' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-23') }
        it 'updates an existing movie\'s metadata' do
            put :update, id: movie.id, movie: movie.attributes()
            movie.reload
            expect(movie.title).to eql('Title1')
        end
    end
    
    describe 'delete destroy' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-23') }
        it 'deletes the movie from the DB' do
            delete :destroy, id: movie.id
            expect(Movie.count).to eq(0)
        end
    end
end