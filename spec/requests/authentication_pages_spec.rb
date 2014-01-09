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
			sign_in user
		end

		it { should have_title(user.name)}
    it { should have_link('Users',      href: users_path)}
    it { should have_link('Profile', 		href: user_path(user)) }
    it { should have_link('Settings',    href: edit_user_path(user))}
		it { should have_link('Sign out', 		href: signout_path)}
		it { should_not have_link('Sign in',	href: signin_path)}

		describe "followed by sign out" do
			before { click_link "Sign out"}
			it { should have_link 'Sign in'}
		end
	end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user)}

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in')}
        end
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user)}
      let(:non_admin) { FactoryGirl.create(:user)}

      before { sign_in non_admin, no_capybara:true }

      describe "submitting a DELETE request to the Users#destroy" do
        before { delete user_path(user)}
        specify { expect(response).to redirect_to(root_url)}
      end
    end
  end
end
