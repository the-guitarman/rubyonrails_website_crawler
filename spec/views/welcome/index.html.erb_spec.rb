require 'rails_helper'

# for examples see: https://thoughtbot.com/blog/how-we-test-rails-applications

RSpec.describe "welcome/index.html.erb", type: :view do
  #pending "add some examples to (or delete) #{__FILE__}"

  context 'when the user visit' do
    it 'displays the main links' do
      #assign(:product, build(:product, url: 'http://example.com')

      render

      expect(rendered).to have_link 'News', href: '/news'
    end
  end
end
