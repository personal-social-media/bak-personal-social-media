# frozen_string_literal: true

RSpec.shared_context "identities_create" do
  let(:documentation_title) { "Create identity" }
  let(:documentation_unescaped_url) { "/identities" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      identity: {
        username: {
          type: :string
        },
        name: {
          type: :string
        },
        signature: {
          type: :string
        },
        about: {
          type: :string
        },
        city_name: {
          type: :string
        },
        country_code: {
          type: :string,
          variants: ISO3166::Country.translations.keys.sort
        },
        avatars: {
          type: {
            type: :string
          },
          original: {
            type: :url
          },
          short: {
            type: :url
          },
          original_screenshot: {
            type: :url
          },
          thumbnail_screenshot: {
            type: :url
          },
          desktop: {
            type: :url
          },
          mobile: {
            type: :url
          },
          thumbnail: {
            type: :url
          }
        }
      }
    }
  end
end
