# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  site_url    :text(65535)
#  site_name   :text(65535)
#  title       :text(65535)
#  description :text(65535)
#  picture     :text(65535)
#  published   :boolean          default("0"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :article do
    
  end
end
