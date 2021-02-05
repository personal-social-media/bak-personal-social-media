# frozen_string_literal: true

describe "recovery" do
  before do
    current_user.update(recover_key_saved: false)
    sign_in
  end

  it "sets the recovery for user" do
    visit "/sessions/recovery"
    click_button "Confirm that you saved this information"

    expect(page).to have_current_path "/"
    expect(current_user.reload.recover_key_saved).to be_truthy
  end
end
