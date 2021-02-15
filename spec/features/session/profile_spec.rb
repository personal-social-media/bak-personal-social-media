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
        current_user.reload
        expect(current_user.name).to eq(new_name)
        expect(current_user.gender).to eq(new_gender)
        expect(current_user.about).to eq(new_about)
        expect(current_user.country_code).to eq("PL")
        expect(current_user.city_name).to eq(new_city)
      end
    end

    context "existing picture" do
      let(:sample_uploaded_file) do
        UploadsService::UploadedFile.new(sample_image_tmp, "md5", "name.png")
      end
      let(:add_image) do
        image = ImageFile.create(image: File.open(sample_image_tmp))
        current_user.profile_image = image
      end
      let(:fill_form) do
        within form do
          click_invisible do
            attach_file("profile[uploaded_file]", sample_image_tmp)
          end
        end
      end

      before do
        allow_any_instance_of(ProfileService::Update).to receive(:uploaded_file).and_return(sample_uploaded_file)
      end

      it "changes image" do
        subject
      end
    end

    context "new picture" do
      let(:add_image) { nil }
      let(:sample_uploaded_file) do
        UploadsService::UploadedFile.new(sample_image_tmp, "md5", "name.png")
      end

      let(:fill_form) do
        within form do
          click_invisible do
            attach_file("profile[uploaded_file]", sample_image_tmp)
          end
        end
      end

      before do
        allow_any_instance_of(ProfileService::Update).to receive(:uploaded_file).and_return(sample_uploaded_file)
      end

      it "sets image" do
        subject
        expect(current_user.profile_image).to be_present
      end
    end
  end
end
