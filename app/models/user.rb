class User < ApplicationRecord
  include StringNormalizer

  before_validation do
    self.email = normalize_as_email(email)
    self.email_for_index = email.downcase if email
  end

  validates :email, presence: true, email: { allow_blank: true }

  # allow_blankは必要？
  # Userの情報を編集する時にpasswordが必要かどうかで変わってくる？
  validates :email_for_index, uniqueness: { allow_blank: true }
  after_validation do
    if errors.include?(:email_for_index)
      errors.add(:email, :taken)
      errors.delete(:email_for_index)
    end
  end

  attr_accessor :new_password, :new_password_confirmation

  PASSWORD_REGEXP = /\A[0-9a-zA-Z@_\-]+\z/ # 半角英小文字大文字数字

  # 以下は必要？
  # validates :new_password, presence: true, if: :new_record?
  validates :new_password, presence: true, if: :password_blank?
  validates :new_password, presence: true, confirmation: true,
    format: { with: PASSWORD_REGEXP, allow_blank: true },
    length: { minimum: 8, maximum: 100 }, if: :new_password?

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

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  before_validation do
    self.family_name = normalize_as_name(family_name)
    self.given_name = normalize_as_name(given_name)
    self.family_name_kana = normalize_as_furigana(family_name_kana)
    self.given_name_kana = normalize_as_furigana(given_name_kana)
  end

  HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}\p{alpha}]+\z/
  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  validates :family_name, :given_name, presence: true,
    format: { with: HUMAN_NAME_REGEXP, allow_blank: true }
  validates :family_name_kana, :given_name_kana, presence: true,
    format: { with: KATAKANA_REGEXP, allow_blank: true }

  validate :birthday_cannot_be_in_the_future
  validate :birthday_date_valid

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

  validates :company, presence: true, length: { maximum: 100 }
  validates :department, presence: true, length: { maximum: 100 }
  validates :official_position, presence: true, length: { maximum: 100 }

  def full_name=(full_name)
    names = full_name.split(' ', 2)
    self.family_name = names[0]
    self.given_name = names[1]
  end

  def full_name_kana=(full_name_kana)
    names = full_name_kana.split(' ', 2)
    self.family_name_kana = names[0]
    self.given_name_kana = names[1]
  end

  def full_name
    [ family_name, given_name ].join(' ')
  end

  def full_name_kana
    [ family_name_kana, given_name_kana ].join(' ')
  end
end
