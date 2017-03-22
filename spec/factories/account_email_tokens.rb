# == Schema Information
#
# Table name: account_email_tokens
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  email_for_index :string(255)      not null
#  value           :text(65535)      not null
#  used            :boolean          default("0"), not null
#  agreement       :boolean          default("0"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :account_email_token do
    email 'hoge1@hoge.com'
    agreement true
  end
end
