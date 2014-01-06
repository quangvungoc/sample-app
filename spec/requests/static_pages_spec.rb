require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App"}
	
	describe "Home page" do 
		it "should have the content 'Sample App'" do
			visit root_path
			expect(page).to have_content('Sample App')
		end

		it "should have the title 'Home'" do
			visit root_path
			expect(page).not_to have_title("#{base_title} | Home")
		end
	end

	describe "Help page" do 
		it "should have the content 'Help'" do
			visit help_path
			expect(page).to have_content('Help')
		end

		it "should have the title 'Help'" do
			visit help_path
			expect(page).to have_title("#{base_title} | Help")
		end
	end

	describe "About page" do
		it "should have the content 'About us'" do
			visit about_path
			expect(page).to have_content('About us')
		end

		it "should have the title 'About us'" do
			visit about_path
			expect(page).to have_title("#{base_title} | About us")
		end
	end

	describe "Contact page" do
		it "should have the content 'Contact'" do
			visit contact_path
			expect(page).to have_content('Contact')
		end

		it "should have the title 'Contact'" do
			visit contact_path
			expect(page).to have_title("#{base_title} | Contact")
		end
	end
end