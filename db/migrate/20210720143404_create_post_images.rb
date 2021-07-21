class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|

      t.integer :shop_id
      t.string :post_image

      t.timestamps
    end
  end
end
