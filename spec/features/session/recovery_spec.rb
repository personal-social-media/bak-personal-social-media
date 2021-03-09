# frozen_string_literal: true

require "rails_helper"

describe "recovery" do
  before do
    current_user.update(recovery_key_plain: SecureRandom.hex)
    sign_in
  end

  it "sets the recovery for user" do
    visit "/sessions/recovery"
    click_button "Confirm that you saved this information"

    expect(page).to have_current_path "/"
    expect(current_user.reload.recovery_key_plain).to be_blank
  end
end
