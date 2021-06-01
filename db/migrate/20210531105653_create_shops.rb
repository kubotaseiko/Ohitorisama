class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :user_id
      t.string :shop_name
      t.integer :shop_image_id
      t.text :introduction
      t.string :address
      t.string :tell
      t.string :holiday

      t.timestamps
    end
  end
end
