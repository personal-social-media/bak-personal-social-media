# frozen_string_literal: true

require "rails_helper"

describe "register" do
  let(:token) { Rails.application.secrets.dig(:profile, :login_token) }
  it "registers user" do
    visit "/sessions/register?login_token=#{token}"

    within "form#register" do
      fill_in "Name:", with: "Test"
      fill_in "Username:", with: "Test"

      select "female", from: "Gender:"

      click_button "commit"
    end

    expect(page).to have_current_path "/sessions/recovery"
    expect(Profile.count).to eq(1)
  end
end
