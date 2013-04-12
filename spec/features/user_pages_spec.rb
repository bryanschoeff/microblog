require 'spec_helper'
require 'helpers/utilities.rb'

describe "User Pages" do

  subject { page }


  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 30.times { FactoryGirl.create(:user) } }
    after(:all) { User.delete_all }

    before do
      sign_in user
      visit users_path
    end

    it { source.should have_selector('title', text: 'users') }
    it { should have_selector('h1', text: 'users') }

    it "should list each user" do
      User.paginate(page: 1).each do |user|
        page.should have_selector('li', text: user.name)
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
      end
    end

  end
  describe "Signup page" do

    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign Up') }
    it { source.should have_selector('title', text: 'Microblog Application :: Sign Up') }

  end

  describe "profile page" do

    let (:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { source.should have_selector('title', text: user.name) }

  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my Account" }

    describe "invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "valid information" do

      before do
        fill_in "Name", with: "Bob Ross"
        fill_in "Email", with: "bross@test.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving a user" do
        before { click_button submit }
        let(:user) { User.find_by_email("bross@test.com") }
        it { source.should have_selector('title', text: user.name) }
        it { should have_link('sign out') }
      end

    end

  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1', text: 'Update your profile') }
      it { source.should have_selector('title', text: 'Edit User') }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button 'Save Changes' }
      it { should have_content('error') }
    end

    describe "with valid information" do
      let (:new_name) { "New Name" }
      let (:new_email) { "new@test.com" }

      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm", with: user.password
        click_button 'Save Changes'
      end

      it { source.should have_selector('title', text: new_name) }
    end

  end

end
