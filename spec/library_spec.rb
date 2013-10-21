require 'library'

describe "Library" do 
  subject { Library.new }
  let(:ui) { double(:ui) }

  it 'displays the search results on the ui' do
    mysearch = "Grape"
    subject.add_book( mysearch )
    
    ui.should_receive(:display_search_results).with (
      [Library::Book.new("Grape")]
    )
    result = subject.search_by_title( mysearch, ui )
  end
end
