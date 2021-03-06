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
#  avatar            :text(65535)      not null
#  gender            :integer          default("0"), not null
#  birthday          :date             not null
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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#password=' do
    example '文字列を与えると、hashed_passwordは長さ60の文字列になる' do
      user = User.new
      user.password = 'hoge'
      expect(user.hashed_password).to be_kind_of(String)
      expect(user.hashed_password.size).to eq(60)
    end

    example 'nilを与えると、hashed_passwordはnilになる' do
      user = User.new(hashed_password: 'x')
      user.password = nil
      expect(user.hashed_password).to be_nil
    end
  end

  describe '値の正規化' do
    example 'email前後の空白を除去' do
      user = create(:user, email: ' test@example.com ')
      expect(user.email).to eq('test@example.com')
    end

    example 'emailに含まれる全角英数字記号を半角に変換' do
      user = create(:user, email: 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ')
      expect(user.email).to eq('test@example.com')
    end

    example 'email前後の全角スペースを除去' do
      user = create(:user, email: "\u{3000}test@example.com\u{3000}")
      expect(user.email).to eq('test@example.com')
    end

    example 'family_name_kanaに含まれるひらがなをカタカナに変換' do
      user = create(:user, family_name_kana: 'てすと')
      expect(user.family_name_kana).to eq('テスト')
    end

    example 'family_name_kanaに含まれる半角カナを全角カナに変換' do
      user = create(:user, family_name_kana: 'ﾃｽﾄ')
      expect(user.family_name_kana).to eq('テスト')
    end
  end

  describe 'バリデーション' do
    example '@@を2個含むemailは無効' do
      user = build(:user, email: 'test@@example.com')
      expect(user).not_to be_valid
    end

    example '記号を含むfamily_name_kanaは無効' do
      user = build(:user, family_name_kana: '試験★')
      expect(user).not_to be_valid
    end

    example '漢字を含むfamily_name_kanaは無効' do
      user = build(:user, family_name_kana: '試験')
      expect(user).not_to be_valid
    end

    example '長音符を含むfamily_name_kanaは有効' do
      user = build(:user, family_name_kana: 'エリー')
      expect(user).to be_valid
    end

    example '重複したemailは無効' do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      expect(user2).not_to be_valid
    end

    example 'new_passwordが半角英小文字大文字数字以外は無効' do
      user = build(:user,
        new_password: 'Password1!',
        new_password_confirmation: 'Password1!')
      expect(user).not_to be_valid
    end

    example 'new_passwordが8文字以上無ければ無効' do
      user = build(:user,
        new_password: 'p',
        new_password_confirmation: 'p')
      expect(user).not_to be_valid
    end

    example 'birthdayが今日より前なら有効' do
      user = build(:user, birthday: Date.yesterday)
      expect(user).to be_valid
    end

    example 'birthdayが今日なら有効' do
      user = build(:user, birthday: Date.today)
      expect(user).to be_valid
    end

    example 'birthdayが未来の日付は無効' do
      user = build(:user, birthday: Date.tomorrow)
      expect(user).not_to be_valid
    end

    example 'birthdayが存在しない日付は無効' do
      user = build(:user, birthday: {1=>2017, 2=>2, 3=>31})
      expect(user).not_to be_valid
    end
  end
end
