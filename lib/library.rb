require_relative 'library/bookshelf'
class Library
  attr_reader :books
  def initialize
    @books = Bookshelf.new
  end

  def add_book(title)
    @books.add Book.new(title)
  end

  def search_by_title(title, ui)
    result = @books.search_by_title title
    ui.display_search_results(result)
  end

  class Book < Struct.new(:title)
  end
end

class SearchResultsPage < Struct.new(:controller)
  def display_search_results(results)
    controller.erb :search, locals: { results: results }
  end
end

require 'sinatra'
configure do 
  library = Library.new
  set :library, library
end

helpers do
  def library
    settings.library
  end
end

get '/' do
  erb :index
end

get '/search' do
  library.search_by_title(params[:query], SearchResultsPage.new(self))
end

get '/add' do
  erb :add
end

post '/add' do
  library.add_book params[:title]
  redirect '/'
end
