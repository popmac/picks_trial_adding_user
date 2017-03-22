class PasswordToken < ApplicationRecord
  belongs_to :user

  before_save do
    self.value = PasswordToken.create_salt
  end

  def token_used
    update_column(:used, true)
  end

  def within_time
    created_at > Time.now - 24.hours
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
