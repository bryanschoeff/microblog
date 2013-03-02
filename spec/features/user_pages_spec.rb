require 'spec_helper'

describe "User Pages" do

  subject { page }


  describe "Signup page" do

    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign Up') }
    it { source.should have_selector('title', text: 'Microblog Application :: Sign Up') }
  end
end
