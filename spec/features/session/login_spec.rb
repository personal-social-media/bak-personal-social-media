# frozen_string_literal: true

require "rails_helper"

describe "login" do
  let(:profile) { create(:profile) }

  subject do
    visit "/sessions/login"

    within "form#login" do
      fill_in "Recovery code", with: code

      click_button "commit"
    end
  end

  context "valid" do
    let(:code) { profile.recover_key }
    it "logins the user" do
      subject

      expect(page).to have_current_path "/"
    end
  end

  context "invalid" do
    let(:code) { "omg" }
    it "logins the user" do
      subject

      expect(page).to have_current_path "/sessions/login"
    end
  end
end
