FactoryGirl.define do
  factory :user do
    ppid { FFaker::Internet.user_name }
    display_name { FFaker::Name.name }

    transient do
      # Allow for custom groups when a user is instantiated.
      # @example FactoryGirl.create(:user, groups: 'admin')
      groups []
    end

    after(:build) do |user, evaluator|
      # In case we have the instance but it has not been persisted
      ::RSpec::Mocks.allow_message(user, :groups).and_return(Array.wrap(evaluator.groups))
      # Given that we are stubbing the class, we need to allow for the original to be called
      ::RSpec::Mocks.allow_message(user.class.group_service, :fetch_groups).and_call_original
      # We need to ensure that each instantiation of the admin user behaves as expected.
      # This resolves the issue of both the created object being used as well as re-finding the created object.
      ::RSpec::Mocks.allow_message(user.class.group_service, :fetch_groups).with(user: user).and_return(Array.wrap(evaluator.groups))
    end

    factory :admin do
      groups ['admin']
    end

    factory :ateer do
      email ["ateer@example.com"]
    end

    trait :guest do
      guest true
    end
  end
end
