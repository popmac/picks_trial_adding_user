class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :email_for_index, null: false
      t.string :family_name, null: false
      t.string :given_name, null: false
      t.string :family_name_kana, null: false
      t.string :given_name_kana, null: false
      t.string :hashed_password
      t.integer :gender, null: false, default: 0
      t.date :birthday
      t.string :company, null: false
      t.string :department, null: false
      t.string :official_position, null: false
      t.boolean :suspended, null:false, default: false

      t.timestamps
    end

    add_index :users, [ :family_name_kana, :given_name_kana ]
  end
end
