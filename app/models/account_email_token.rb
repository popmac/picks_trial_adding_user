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

class AccountEmailToken < ApplicationRecord
  include EmailHolder

  validates :agreement, :acceptance =>true

  before_save do
    self.value = AccountEmailToken.create_salt
  end

  def token_used
    update_column(:used, true)
  end

  def within_time
    created_at > Time.now - 48.hours
  end

  class << self
    def create_salt
      d = Digest::SHA1.new
      now = Time.now
      d.update(now.to_s)
      d.update(String(now.usec))
      d.update(String(rand(0)))
      d.update(String($$))
      d.update('at2')
      d.hexdigest
    end
  end
end
