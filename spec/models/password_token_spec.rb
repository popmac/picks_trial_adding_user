# == Schema Information
#
# Table name: password_tokens
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  value      :text(65535)      not null
#  used       :boolean          default("0"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_password_tokens_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe PasswordToken, type: :model do
end
