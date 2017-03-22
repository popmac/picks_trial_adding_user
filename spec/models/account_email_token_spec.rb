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

require 'rails_helper'

RSpec.describe AccountEmailToken, type: :model do
  describe 'アカウント登録のためのtokenを生成' do
    example '利用規約にチェックがなければ無効' do
      token = build(:account_email_token, agreement: false)
      expect(token).not_to be_valid
    end
    example 'メールアドレスの入力がなければ無効' do
      token = build(:account_email_token, email: nil)
      expect(token).not_to be_valid
    end
    example '大文字の入ったメールアドレスはすべて小文字に変換される' do
      token = create(:account_email_token, email: 'Hoge1@hoge.com')
      expect(token.email_for_index).to eq('hoge1@hoge.com')
    end
  end
end
