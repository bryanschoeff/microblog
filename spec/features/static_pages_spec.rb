require 'spec_helper'

describe "Static Pages" do

  subject { page }

  describe "Home Page" do
    before { visit root_path }

    it { should have_selector('h1', text: 'Microblog Application') }
    it { source.should_not have_selector('title', text: ':: Home') }
  end

  describe "Help Page" do
    before { visit help_path }

    it { should have_selector('h1', text: 'Microblog Application :: Help') }
    it { source.should have_selector('title', text: 'Microblog Application :: Help') }
  end

  describe "About Page" do
    before { visit about_path }

    it { should have_selector('h1', text: 'Microblog Application :: About Us') }
    it { source.should have_selector('title', text: 'Microblog Application :: About Us') }
  end

  describe "Contact Page" do
    before { visit contact_path }

    it { should have_selector('h1', text: 'Microblog Application :: Contact') }
    it { source.should have_selector('title', text: 'Microblog Application :: Contact') }
  end

end
