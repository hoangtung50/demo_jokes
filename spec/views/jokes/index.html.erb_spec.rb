require "rails_helper"

RSpec.describe "jokes/index" do
  it "displays first joke" do

      assign(:joke, Joke.first)
      render

      expect(rendered).to have_selector('h1', :text => 'Welcome to the Jokes App')
      expect(rendered).to have_selector('h3', :text => 'A child asked his father')
  end

  it "displays second joke" do

      assign(:joke, Joke.first(2)[1])
      render

      expect(rendered).to have_selector('h1', :text => 'Welcome to the Jokes App')
      expect(rendered).to have_selector('h3', :text => 'Kids,what does the chicken give you?')
  end

  it "displays no joke" do

      assign(:joke, nil)
      render

      expect(rendered).to have_selector('h1', :text => 'Welcome to the Jokes App')
      expect(rendered).to have_selector('h3', :text => "That's all the jokes for today! Come back another day!")
  end

  it "displays link like and dislike" do
      assign(:joke, Joke.first)
      render

      expect(rendered).to have_selector('a', :text => 'Like')
      expect(rendered).to have_selector('a', :text => 'Dislike')
  end

  it "no displays link like and dislike" do
      assign(:joke, nil)
      render

      expect(rendered).to_not have_selector('a', :text => 'Like')
      expect(rendered).to_not have_selector('a', :text => 'Dislike')
  end
end