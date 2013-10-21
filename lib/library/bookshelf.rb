require 'forwardable'
class Bookshelf
  extend Forwardable
  include Enumerable

  def_delegators :@books, :<<, :each, :size

  def initialize(books = [])
    @books = books
  end

  def add(book)
    @books << book
  end

  def search_by_title(title)
    raise ArgumentError, "invalid search" if !title || title.to_s.strip.length < 1
    @books.find_all { |n| n if n.title.downcase.match title.downcase }
  end

  require 'mongoid'
  class MongoBookshelf

    def initialize(database)
      Mongoid.configure do |config|
          config.master = ::Mongo::Connection.new.db(database)
      end
    end

    def search_by_title(title)

    raise ArgumentError, "invalid search" if !title || title.to_s.strip.length < 1
      MongoBook.where(title: /#{title}/i).to_a.map do |mongo_book|
        Library::Book.new(mongo_book.title)
      end
    end

    def add(book)
      new_book = MongoBook.new(title: book.title)
      new_book.save
    end

    def delete_all
      MongoBook.delete_all
    end
  end

  class MongoBook
    include Mongoid::Document

    field :title
  end
end
