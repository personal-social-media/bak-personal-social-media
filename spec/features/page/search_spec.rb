# frozen_string_literal: true

require "rails_helper"

describe "top search" do
  include FilesSpecHelper

  describe "can search" do
    before do
      create_list(:peer_info, 3, name: content)
    end

    let(:url) { "/" }
    let(:form) { "form#profile-form" }
    let(:component) { "#top-search" }
    let(:content) { "test" }
    let(:search) do
      within component do
        screenshot
        find_field("query").fill_in with: content
      end
    end

    context "returns some profiles" do
      it do
        # sign_in
        # visit url
        # screenshot
        # search
        # container = find(".local-searches-list")
        # expect(container.children.size).to be > 0
      end
    end
  end
end
