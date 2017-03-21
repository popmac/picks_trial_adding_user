require 'rails_helper'

RSpec.describe Customer::Authenticator do
  describe '#authenticate' do
    example '正しいパスワードならtrueを返す' do
      u = build(:user)
      expect(Customer::Authenticator.new(u).authenticate('password')).to be_truthy
    end

    example '誤ったパスワードならfalseを返す' do
      u = build(:user)
      expect(Customer::Authenticator.new(u).authenticate('xy')).to be_falsey
    end

    example 'パスワードが未設定ならfalseを返す' do
      u = build(:user, password: nil)
      expect(Customer::Authenticator.new(u).authenticate(nil)).to be_falsey
    end

    example '停止フラグが立っていてもtrueを返す' do
      u = build(:user, suspended: true)
      expect(Customer::Authenticator.new(u).authenticate('password')).to be_truthy
    end
  end
end
