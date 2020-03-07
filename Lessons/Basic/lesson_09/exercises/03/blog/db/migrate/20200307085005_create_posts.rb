class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :subject
      t.string :content
      t.date :published_on

      t.timestamps
    end
  end
end
