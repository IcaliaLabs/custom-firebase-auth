# frozen_string_literal: true

require 'system_helper'

RSpec.describe 'Firebase', type: :system do
  scenario "User can see Sign Up page" do
    visit signup_path
    expect(page).to have_content 'Sign up'
  end

  scenario "User can see Login page" do
    visit login_path
    expect(page).to have_content 'Log in'
  end
end
