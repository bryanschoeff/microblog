require 'spec_helper'

describe "Static Pages" do

  describe "Home Page" do

    it "should have the h1 'Microblog Application'" do
      visit '/static_pages/home'
      page.should have_selector('h1', text: 'Microblog Application')
    end

    it "should not have a custom title title" do
      visit '/static_pages/home'
      page.source.should_not have_selector('title', text: ':: Home')
    end

  end

  describe "Help Page" do

    it "should have the h1 'Microblog Application :: Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', text: 'Microblog Application :: Help')
    end

    it "should have the correct title" do
      visit '/static_pages/help'
      page.source.should have_selector('title', text: 'Microblog Application :: Help')
    end

  end

  describe "About Page" do

    it "should have the h1 'Microblog Application :: About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', text: 'Microblog Application :: About Us')
    end

    it "should have the correct title" do
      visit '/static_pages/about'
      page.source.should have_selector('title', text: 'Microblog Application :: About Us')
    end

  end


end
