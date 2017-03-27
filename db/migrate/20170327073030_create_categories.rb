class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.text :name, null: false
      t.integer :sort_order, null: false

      t.timestamps
    end
  end
end
