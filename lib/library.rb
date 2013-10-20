class Library
  attr_reader :books
  def initialize
    @books = []
  end

  def add_book(title)
    @books << Book.new(title)
  end

  def search_by_title(title)
    raise ArgumentError if title.to_s.strip.length < 1
    @books.find_all { |n| n if n.title.downcase.match title.downcase }.map(&:title)
  end

  class Book < Struct.new(:title)
  end
end

require 'sinatra'
configure do 
  library = Library.new
  set :library, library
end

get '/' do
  erb :index
end

get '/search' do
  @results = settings.library.search_by_title(params[:query])
  erb :search
end

get '/add' do
  erb :add
end

post '/add' do
  settings.library.add_book params[:title]
  redirect '/'
end
