  FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }

    trait :with_profile do
      after :build do |user|
        build(:profile, user: user)  #userが作成されたときにprofileを作成できる. profiles.rbから参照
      end
    end
  end
end