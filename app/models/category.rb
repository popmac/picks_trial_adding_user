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

class Category < ApplicationRecord
  has_many :articles
  validates :name, uniqueness: true
  validates :sort_order, uniqueness: true

  def last_sort_order
    if Category.exists?
      last_category = Category.order(sort_order: :asc).last
      last_category.sort_order + 1
    else
      1
    end
  end
end
