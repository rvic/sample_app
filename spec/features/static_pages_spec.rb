require 'spec_helper'

describe "Static Pages" do
  describe "Home page" do
    it "should have h1 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      #page.should have_content('Sample App')
      page.should have_selector('h1', :text => 'Sample App')
      #response.status.should be(200)
    end
    it "should have the base title" do
      visit '/static_pages/home'
      #page.source.should have_xpath('//title[contains(.,"Ruby on Rails Tutorial Sample App | Home")]')
      page.should have_title("Ruby on Rails Tutorial Sample App")
    end
    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_title("| Home")
    end
  end
  describe "Help page" do
    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      #page.should have_content('Help')
      page.should have_selector('h1', :text => 'Help')
    end
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      #page.source.should have_xpath('//title[contains(.,"Ruby on Rails Tutorial Sample App | Help")]')
      page.should have_title("Help")
    end
  end
  describe "About page" do
    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      #page.should have_content('About Us')
      page.should have_selector('h1', :text => 'About Us')
    end
    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      #page.source.should have_xpath('//title[contains(.,"Ruby on Rails Tutorial Sample App | About Us")]')
      page.should have_title("About Us")
    end
  end
  describe "Contact page" do
    it "should have the h1 'Contact'" do
      visit '/static_pages/contact'
      #page.should have_content('About Us')
      page.should have_selector('h1', :text => 'Contact')
    end
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      #page.source.should have_xpath('//title[contains(.,"Ruby on Rails Tutorial Sample App | About Us")]')
      page.should have_title("Contact")
    end
  end
end


