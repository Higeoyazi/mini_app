FactoryBot.define do
  factory :tweet do
    text {"hello!"}
    # created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
  end
end
