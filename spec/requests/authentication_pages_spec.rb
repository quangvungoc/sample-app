require 'spec_helper'
require 'support/authentication_helper'

describe "AuthenticationPages" do

	subject { page }
	before { visit signin_path }

  	describe "sign in page" do
  		it { should have_content('Sign in')}
  		it { should have_title('Sign in')}
  	end

  	describe "invalid sign in information" do
  		before { click_button "Sign in"}
  		it { should have_title('Sign in')}
  		it { should have_selector('div.alert.alert-error')}

  		describe "after visit another page" do
  			before { click_link "Home"}
  			it { should_not have_selector('div.alert.alert-error')}
  		end
  	end

  	describe "valid sign in" do
  		let(:user) {FactoryGirl.create(:user)}
  		before do
  			valid_signin(user)
  		end

  		it { should have_title(user.name)}
  		it { should have_link('Profile', 		href: user_path(user)) }
  		it { should have_link('Sign out', 		href: signout_path)}
  		it { should_not have_link('Sign in',	href: signin_path)}

  		describe "followed by sign out" do
  			before { click_link "Sign out"}
  			it { should have_link 'Sign in'}
  		end
  	end
end
