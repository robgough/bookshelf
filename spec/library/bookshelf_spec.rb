require 'library'
class Library
  describe Bookshelf do 
    subject { Library.new }
    let(:bookshelf) { Bookshelf.new }

    it 'should error when searching with empty string' do
      mysearch = ""
      expect{bookshelf.search_by_title(mysearch)}.to raise_error(ArgumentError, "invalid search")
    end

    it 'should error when searching with whitespace only string' do
      mysearch = "  "
      expect{bookshelf.search_by_title(mysearch)}.to raise_error(ArgumentError, "invalid search")
    end

    it 'should error when searching with nil' do
      expect{bookshelf.search_by_title(nil)}.to raise_error(ArgumentError, "invalid search")
    end

    it 'should find books with a partial match' do
      bookshelf.add( a_book('Sociology') )
      bookshelf.add( a_book('Psychology') )
      bookshelf.add( a_book('History') )
      mysearch = "ology"

      results = bookshelf.search_by_title(mysearch)
      expect( results ).to eq(
        [a_book('Sociology'), a_book('Psychology')]
      )
    end

    it 'searches without case sensitivity' do
      bookshelf.add( a_book('Sociology') )

      results = bookshelf.search_by_title("sociology")
      expect( results ).to eq(
        [a_book('Sociology')]
      )
    end

    def a_book(title)
      Library::Book.new(title)
    end
  end
end
