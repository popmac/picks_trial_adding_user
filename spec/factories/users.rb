FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    family_name '山田'
    given_name '太郎'
    family_name_kana 'ヤマダ'
    given_name_kana 'タロウ'
    birthday '2017-03-20'
    gender 0
    company 'テスト会社'
    department 'テスト部'
    official_position 'テスト長'
  end
end
