require 'spec_helper'

describe "Static Pages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(page_title) }
  end

  describe "Home page" do
    before { visit root_path }

    #it { should have_selector('h1', :text => 'Sample App') }
    #it { should have_title("Ruby on Rails Tutorial Sample App") }    

    let(:heading) { 'Sample App' }
    let(:page_title) { 'Ruby on Rails Tutorial Sample App' }

    it_should_behave_like "all static pages"
    it { should_not have_title("| Home") }

    #it "should have h1 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      #visit '/static_pages/home'
      #page.should have_content('Sample App')
      # page.should have_selector('h1', :text => 'Sample App')
      #response.status.should be(200)
    # end
    #it "should have the base title" do
      # visit '/static_pages/home'
      #page.source.should have_xpath('//title[contains(.,"Ruby on Rails Tutorial Sample App | Home")]')
    #  page.should have_title("Ruby on Rails Tutorial Sample App")
    #end
    # it "should not have a custom page title" do
      # visit '/static_pages/home'
    #  page.should_not have_title("| Home")
    #end
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end
      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end
  describe "Help page" do
    before { visit help_path }
    #it { should have_selector('h1', :text => 'Help') }
    #it { should have_title("Help") }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"

    #it "should have the h1 'Help'" do
      # visit '/static_pages/help'
    #  visit help_path
      #page.should have_content('Help')     
    #  page.should have_selector('h1', :text => 'Help')
    #end
    # it "should have the title 'Help'" do
      # visit '/static_pages/help'
    #  visit help_path
      #page.source.should have_xpath('//title[contains(.,"Ruby on Rails Tutorial Sample App | Help")]')
    #  page.should have_title("Help")
    #end
  end
  describe "About page" do
    before { visit about_path }
    #it { should have_selector('h1', :text => 'About Us') }
    #it { should have_title("About Us") }

    let(:heading) { 'About Us' }
    let(:page_title) { 'About Us' }

    it_should_behave_like "all static pages"

    #it "should have the h1 'About Us'" do
      # visit '/static_pages/about'
    #  visit about_path
      #page.should have_content('About Us')
    #  page.should have_selector('h1', :text => 'About Us')
    #end
    #it "should have the title 'About Us'" do
      # visit '/static_pages/about'
    #  visit about_path
      #page.source.should have_xpath('//title[contains(.,"Ruby on Rails Tutorial Sample App | About Us")]')
    #  page.should have_title("About Us")
    # end
  end
  describe "Contact page" do
    before { visit contact_path }
    #it { should have_selector('h1', :text => 'Contact') }
    #it { should have_title("Contact") }

    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"

    #it "should have the h1 'Contact'" do
      #visit '/static_pages/contact'
    #  visit contact_path
      #page.should have_content('About Us')
    #  page.should have_selector('h1', :text => 'Contact')
    #end
    #it "should have the title 'Contact'" do
      # visit '/static_pages/contact'
    #  visit contact_path
      #page.source.should have_xpath('//title[contains(.,"Ruby on Rails Tutorial Sample App | About Us")]')
    #  page.should have_title("Contact")
    #end
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_title('About Us')
    click_link "Help"
    page.should have_title('Help')
    click_link "Contact"
    page.should have_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_title('Sign up')
    #click_link "sample app"
    #page.should # fill in
  end

end


