class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.text :site_url     # 引用元のURL
      t.text :site_name    # 引用元のサイト名
      t.text :title        # 記事のタイトル
      t.text :description  # 引用元のdescription
      t.text :picture
      t.boolean :published, null: false, default: false

      t.timestamps
    end
  end
end
