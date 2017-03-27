# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :text(65535)      not null
#  sort_order :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
end
