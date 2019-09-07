FactoryBot.define do
  factory :tweet do
    text {"hello!"}
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
    user
  end
end