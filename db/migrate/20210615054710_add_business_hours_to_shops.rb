class AddBusinessHoursToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :business_hours, :string
  end
end
