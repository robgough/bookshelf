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
end
