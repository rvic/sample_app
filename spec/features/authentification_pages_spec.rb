require 'spec_helper'

describe "Authentification" do
  subject { page }

  describe "signing page" do
    before { visit signin_path }
    it { should have_selector("h1", text:"Sign in") }
    it { should have_title("Sign in") }
  end

  describe "signin" do
    before { visit signin_path }
    describe "with invalid information" do
      before { click_button "Sign in" }
      it { should have_title("Sign in") }
      #it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      it { should have_error_message('Invalid') }
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      #before do
      #  fill_in "Email", with: user.email
      #  fill_in "Password", with: user.password
      #  click_button "Sign in"
      #end
      #before { valid_signin(user) }
      before { sign_in user }
      it { should have_title(user.name) }
      it { should have_link('Users', users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      describe "in the Users controller" do
#        describe "visiting the edit page" do
#          before { visit edit_user_path(user) }
#          it { should have_title('Sign in') }
#        end
#        describe "submitting to the update action" do
#          before { put user_path(user) }
#          specify { response.should redirect_to(signin_path) }
#        end
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end
        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it { should have_title('Sign in') }
        end
        describe "visiting the followers page" do
          before { visit followers_user_path(user) }
          it { should have_title('Sign in') }
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            page.should have_title('Edit user')
          end
        end

        describe "when signing in again" do
          before do
            visit signin_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"
          end
          it "should render the default (profile) page" do
            page.should have_title(user.name)
          end
        end
 
      end

      describe "There shouldn't be Profile and Settings links"
        it { should_not have_link('Profile', href: user_path(user)) }
        it { should_not have_link('Settings', href: edit_user_path(user)) }
      end

    end

    context "as a wrong user" do
      let(:user)       { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }

      before do
        visit root_path
        click_link "Sign in"
        sign_in_through_ui(user)
      end

      context "visiting Users#edit" do
        let(:page_title) { full_title("Edit User") }
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title(page_title) }
      end
    end

#  end

end
