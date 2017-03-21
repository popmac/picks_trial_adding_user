class CreateAccountEmailTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :account_email_tokens do |t|
      t.string :email, null: false
      t.string :email_for_index, null: false
      t.text :value, null: false
      t.boolean :used, null: false, default: false
      t.boolean :agreement, null: false, default: false

      t.timestamps
    end
  end
end
