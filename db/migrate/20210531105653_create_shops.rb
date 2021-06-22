class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :user_id
      t.string :shop_name
      t.string :shop_image_id
      t.text :introduction
      t.string :address
      t.string :tell
      t.string :holiday
      t.string :business_hours
      t.float :rate_average
      t.float :latitude
      t.float :longitude
        
      t.timestamps
    end
  end
end
