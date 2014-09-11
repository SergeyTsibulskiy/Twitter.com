FactoryGirl.define do

  factory :user do
    fullname 'SergeyTsibulskiy'
    email 'c4r0n0s@gmail.com'
    password '11111111'
  end

  factory :tweet do
    tweet 'Test'
    association :user, factory: :user
  end

  factory :follower do
    association :user, factory: :user
    association :follow, factory: :user
  end

end