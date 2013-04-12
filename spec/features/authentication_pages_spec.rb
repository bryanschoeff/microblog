require 'spec_helper'

describe "Authentication Pages" do

  subject { page }

  describe "sign in page" do
      before { visit signin_path }

      it { should have_selector('h1', text: 'Sign In') }
      it { source.should have_selector('title', text: 'Sign In') }
  end

  describe "sign in" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign In" }

      it { source.should have_selector('title', text: 'Sign In') }
      it { should have_selector('div.alert.alert-error', text: 'invalid') }

      describe "after visiting another page" do
        before { click_link "home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
      end

      it { source.should have_selector('title', text: user.name) }
      it { should have_link('profile', href: user_path(user)) }
      it { should have_link('sign out', href: signout_path) }
      it { should have_link('settings', href: edit_user_path(user)) }
      it { should have_link('users', href: users_path) }
      it { should_not have_link('sign in', href: signin_path) }

    end

  end

  describe "authorization" do

    describe "for non-signed-in users" do
      # let(:user) { FactoryGirl.create(:user) }

      # describe "submitting to the update action" do
      #   before { put user_path(user) }
      #   specify { response.should redirect_to(signin_path) }
      # end

    end

    describe "in the Users controller" do

      describe "visiting the user index" do
        before { visit users_path }
        it { source.should have_selector('title', text: 'Sign In') }
      end
    end

  end

end
