class CreateTweetComments < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :tweet_id

      t.timestamps
    end
  end
end
