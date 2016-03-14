require 'rails_helper'

describe "Joke page process", :type => :feature do
  it "displays first joke" do
    visit jokes_path
    expect(page).to have_selector('h1', :text => 'Welcome to the Jokes App')
    expect(page).to have_selector('h3', :text => 'A child asked his father')
    expect(page).to have_selector('a', :text => 'Like')
    expect(page).to have_selector('a', :text => 'Dislike')
  end
  it "creates vote then show second joke", :js => true  do
    visit jokes_path
    expect(Vote.count).to eq(0)
    click_link 'Like'
    sleep 1
    expect(Vote.count).to eq(1)
    expect(Vote.last.joke_id).to eq(Joke.first.id)
    expect(Vote.last.like).to eq(true)
    expect(page).to have_selector('h1', :text => 'Welcome to the Jokes App')
    expect(page).to have_selector('h3', :text => 'Teacher: "Kids,what does the chicken give you?')
    # again
    visit jokes_path
    expect(page).to have_selector('h1', :text => 'Welcome to the Jokes App')
    expect(page).to have_selector('h3', :text => 'Teacher: "Kids,what does the chicken give you?')
  end

  it "creates vote for all jokes then show no joke", :js => true  do
    visit jokes_path
    expect(Vote.count).to eq(0)
    click_link 'Like'
    sleep 1
    click_link 'Like'
    sleep 1
    click_link 'Like'
    sleep 1
    click_link 'Like'
    sleep 1
    expect(Vote.count).to eq(4)
    expect(page).to have_selector('h1', :text => 'Welcome to the Jokes App')
    expect(page).to have_selector('h3', :text => "That's all the jokes for today! Come back another day!")
    # again
    visit jokes_path
    expect(page).to have_selector('h1', :text => 'Welcome to the Jokes App')
    expect(page).to have_selector('h3', :text => "That's all the jokes for today! Come back another day!")
  end

  it "reset cookies user and displays first joke", :js => true  do
    visit jokes_path
    expect(Vote.count).to eq(0)
    click_link 'Like'
    sleep 1
    click_link 'Like'
    sleep 1
    click_link 'Like'
    sleep 1
    click_link 'Like'
    sleep 1
    expect(Vote.count).to eq(4)
    expect(page).to have_selector('h1', :text => 'Welcome to the Jokes App')
    expect(page).to have_selector('h3', :text => "That's all the jokes for today! Come back another day!")
    # clear cookies
    browser = Capybara.current_session.driver.browser
    if browser.respond_to?(:clear_cookies)
      # Rack::MockSession
      browser.clear_cookies
    elsif browser.respond_to?(:manage) and browser.manage.respond_to?(:delete_all_cookies)
      # Selenium::WebDriver
      browser.manage.delete_all_cookies
    else
      raise "Don't know how to clear cookies. Weird driver?"
    end
    # again
    visit jokes_path
    expect(page).to have_selector('h1', :text => 'Welcome to the Jokes App')
    expect(page).to have_selector('h3', :text => 'A child asked his father')
  end


end