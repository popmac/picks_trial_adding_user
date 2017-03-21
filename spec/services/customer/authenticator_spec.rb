require 'rails_helper'

RSpec.describe Customer::Authenticator do
  describe '#authenticate' do
    example '正しいパスワードならtrueを返す' do
      m = build(:user)
      expect(Customer::Authenticator.new(m).authenticate('password')).to be_truthy
    end

    example '誤ったパスワードならfalseを返す' do
      m = build(:user)
      expect(Customer::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example 'パスワードが未設定ならfalseを返す' do
      m = build(:user, password: nil)
      expect(Customer::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example '停止フラグが立っていてもtrueを返す' do
      m = build(:user, suspended: true)
      expect(Customer::Authenticator.new(m).authenticate('password')).to be_truthy
    end
  end
end
