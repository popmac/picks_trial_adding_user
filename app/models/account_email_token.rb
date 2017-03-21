class AccountEmailToken < ApplicationRecord
  include StringNormalizer

  before_validation do
    self.email = normalize_as_email(email)
    self.email_for_index = email.downcase if email
  end

  validates :agreement, :acceptance =>true

  validates :email, presence: true, email: { allow_blank: true }

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
