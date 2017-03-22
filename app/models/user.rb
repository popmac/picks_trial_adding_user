class User < ApplicationRecord
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_many :password_tokens, dependent: :destroy

  attr_accessor :new_password, :new_password_confirmation

  PASSWORD_REGEXP = /\A[0-9a-zA-Z@_\-]+\z/ # 半角英小文字大文字数字

  # allow_blankは必要？
  # Userの情報を編集する時にpasswordが必要かどうかで変わってくる？
  validates :email_for_index, uniqueness: { allow_blank: true }
  # 以下は必要？
  # validates :new_password, presence: true, if: :new_record?
  validates :new_password, presence: true, if: :password_blank?
  validates :new_password, presence: true, confirmation: true,
    format: { with: PASSWORD_REGEXP, allow_blank: true },
    length: { minimum: 8, maximum: 100 }, if: :new_password?
  validate :birthday_cannot_be_in_the_future
  validate :birthday_date_valid
  validates :company, presence: true, length: { maximum: 100 }
  validates :department, presence: true, length: { maximum: 100 }
  validates :official_position, presence: true, length: { maximum: 100 }

  def password_blank?
    hashed_password.blank?
  end

  def new_password?
    new_password.present?
  end

  before_save do
    if new_password.present?
      self.password = new_password
    end
  end

  def birthday_cannot_be_in_the_future
    if birthday.present? && birthday > Date.today
      errors.add(:birthday, "が未来の日付になっています。")
    end
  end

  def birthday_date_valid
    if birthday_before_type_cast.kind_of?(Hash)
      if birthday_before_type_cast.present?
        date_ary = birthday_before_type_cast
        y = date_ary[1]
        m = date_ary[2]
        d = date_ary[3]
        unless Date.valid_date?(y, m, d)
          errors.add(:birthday, "が存在しない日付になっています。")
        end
      end
    end
  end
end
