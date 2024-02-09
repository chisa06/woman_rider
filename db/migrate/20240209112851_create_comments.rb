class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :tweet_id, null: false
      t.integer :user_id, null: false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
