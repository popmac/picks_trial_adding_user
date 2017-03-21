class CreatePasswordTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :password_tokens do |t|
      t.references :user, null: false
      t.text :value, null: false
      t.boolean :used, null: false, default: false

      t.timestamps
    end
  end
end
