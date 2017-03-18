class AccountEmailToken < ApplicationRecord
  before_validation do
    self.email_for_index = email.downcase if email
  end

  validates :email, presence: true, email: { allow_blank: true }

  # validates :email_for_index, uniqueness: { allow_blank: true }
  # after_validation do
  #   if errors.include?(:email_for_index)
  #     errors.add(:email, :taken)
  #     errors.delete(:email_for_index)
  #   end
  # end

  before_save do
    self.value = AccountEmailToken.create_salt
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