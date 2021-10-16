require 'rails_helper'

describe MoviesController do
    describe 'get show action' do
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
    
    describe 'get homepage action' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-01') }
        before(:each) do
            get :index
        end
        it 'should display the index.html.erb template' do
            expect(response).to render_template('index')
        end
        it 'should display the list of movies' do
            movies_list = []
            @controller.instance_variable_get(:@movies).each do |x|
                movies_list.append(x.title)
            end
            expect(movies_list).to eql(['Title1'])
        end
    end
    describe 'get similar movies action' do
        let!(:movie1) { Movie.create!(title: 'Title1', director: 'Director1') }
        let!(:movie2) { Movie.create!(title: 'Title2', director: 'Director1') }
        let!(:movie3){ Movie.create!(title: 'Title3', director: 'Director2') }
        let!(:movie4){ Movie.create!(title: 'Title4', director: '') }
        
        it 'should display the similar_movies.html.erb template' do
            get :find_similar_movies, id: movie1.id
            expect(response).to render_template('find_similar_movies')
        end
        it 'should display the remaining list of movies by director Director1' do
            get :find_similar_movies, id: movie1.id
            movies_list = []
            @controller.instance_variable_get(:@movies).each do |x|
                movies_list.append(x.title)
            end
            expect(movies_list).to eql(['Title1', 'Title2'])
        end
        it 'should display the remaining list of movies by director Director2' do
            get :find_similar_movies, id: movie3.id
            movies_list = []
            @controller.instance_variable_get(:@movies).each do |x|
                movies_list.append(x.title)
            end
            expect(movies_list).to eql(['Title3'])
        end
        it 'should display the index.html.erb' do
            get :find_similar_movies, id: movie4.id
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'get new action' do
        let!(:movie) { Movie.new }
        it 'should display the new template' do
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe 'get create action' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-23') }
        it 'creates a new movie' do
            post :create, movie: movie.attributes()
            expect(Movie.count).to eq(2)
        end
        it 'redirects to the movie index page' do
            post :create, movie: movie.attributes()
            expect(response).to redirect_to(movies_url)
        end
    end

    describe 'get edit action' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-23') }
        it 'should find the movie\'s edit page' do
            get :edit, id: movie.id
            expect(assigns(:movie)).to eql(movie)
        end
        it 'should display the edit.html.erb template' do
            get :edit, id: movie.id
            expect(response).to render_template('edit')
        end
    end
    
    describe 'put update action' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-23') }
        it 'updates an existing movie\'s metadata' do
            put :update, id: movie.id, movie: movie.attributes()
            movie.reload
            expect(movie.title).to eql('Title1')
        end
        it 'redirects to the movie index page' do
            put :update, id: movie.id, movie: movie.attributes()
            expect(response).to redirect_to(movie_path(movie))
        end
    end
    
    describe 'delete destroy action' do
        let!(:movie) { Movie.create!(title: 'Title1', director: 'Director1', rating: 'PG', release_date: '1999-04-23') }
        it 'deletes the movie from the DB' do
            delete :destroy, id: movie.id
            expect(Movie.count).to eq(0)
        end
        it 'redirects to movies#index after destroy' do
            delete :destroy, id: movie.id
            expect(response).to redirect_to(movies_path)
        end
    end
end