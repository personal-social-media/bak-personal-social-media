FactoryBot.define do
  factory :group_membership do
    group { nil }
    role { "MyString" }
    peer_info { nil }
  end
end
