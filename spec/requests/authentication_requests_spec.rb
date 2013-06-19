require 'spec_helper'

describe "Authentication Requests" do

  subject { response }
  # ...
  describe "authorization" do
    # ...
    context "as a wrong user" do
      let(:user)       { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }

      before { sign_in_request(user) }

      context "PUT Users#update" do
        before { put user_path(wrong_user) }
        it { should redirect_to(root_url) }
      end
    end

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end
        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end

      describe "in the Microposts controller" do
        describe "submitting to the create action" do
          before { post microposts_path }
          specify { response.should redirect_to(signin_path) }
        end
        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { response.should redirect_to(signin_path) }
        end
      end
   end

  describe "as non-admin user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:non_admin) { FactoryGirl.create(:user) }
    before { sign_in non_admin }
    describe "submitting a DELETE request to the Users#destroy action" do
      before { delete user_path(user) }
      specify { response.should redirect_to(root_path) }
    end
  end

  describe "as admin user" do
    let(:user) { FactoryGirl.create(:admin) }
    before { sign_in user }
    describe "submitting a DELETE request to the Users#destroy action by admin" do
      before { delete user_path(user) }
      specify { response.should redirect_to(root_path) }
    end
  end


  end
end