# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  email             :string(255)      not null
#  email_for_index   :string(255)      not null
#  family_name       :string(255)      not null
#  given_name        :string(255)      not null
#  family_name_kana  :string(255)      not null
#  given_name_kana   :string(255)      not null
#  hashed_password   :string(255)
#  gender            :integer          default("0"), not null
#  birthday          :date
#  company           :string(255)      not null
#  department        :string(255)      not null
#  official_position :string(255)      not null
#  suspended         :boolean          default("0"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_family_name_kana_and_given_name_kana  (family_name_kana,given_name_kana)
#

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
