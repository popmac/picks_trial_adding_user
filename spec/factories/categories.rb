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

FactoryGirl.define do
  factory :category do
    
  end
end
