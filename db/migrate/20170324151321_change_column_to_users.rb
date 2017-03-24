class ChangeColumnToUsers < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :birthday, :date, null: false
  end

  def down
    change_column :users, :birthday, :date
  end
end
