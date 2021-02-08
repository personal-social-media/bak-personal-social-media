# frozen_string_literal: true

require "rails_helper"

describe "profile" do
  include FilesSpecHelper

  context "update profile" do
    let(:url) { "/sessions/profile" }
    let(:submit_form) { click_button "Update Profile" }
    let(:form) { "form#profile-form" }
    subject do
      sign_in
      add_image
      visit url
      fill_form
      submit_form
      current_user.reload
    end

    context "no picture" do
      let(:add_image) { nil }
      let(:new_name) { "omg_name" }
      let(:new_gender) { "male" }
      let(:new_about) { "omg_about" }
      let(:country_code) { "Poland" }
      let(:new_city) { "Cracow" }

      let(:fill_form) do
        within form do
          fill_in "Name:", with: new_name
          select new_gender, from: "Gender:"
          fill_in "About:", with: new_about
          select country_code, from: "Country:"
          fill_in "City:", with: new_city
        end
      end

      it "updates profile" do
        subject

        expect(current_user.name).to eq(new_name)
        expect(current_user.gender).to eq(new_gender)
        expect(current_user.about).to eq(new_about)
        expect(current_user.country_code).to eq("PL")
        expect(current_user.city_name).to eq(new_city)
        expect(page).to have_content "Saved"
      end
    end

    context "existing picture" do
      let(:add_image) do
        image = ImageFile.create(image: sample_image_tmp)
        current_user.profile_image = image
      end
      let(:fill_form) do
        within form do
          click_invisible do
            attach_file("profile_image", sample_image_tmp.path)
          end
        end
      end

      it "changes image" do
        subject
        expect(page).to have_content "Saved"
      end
    end

    context "new picture" do
      let(:add_image) { nil }

      let(:fill_form) do
        within form do
          click_invisible do
            attach_file("profile_image", sample_image_tmp.path)
          end
        end
      end

      it "sets image" do
        subject
        expect(page).to have_content "Saved"
      end
    end
  end
end