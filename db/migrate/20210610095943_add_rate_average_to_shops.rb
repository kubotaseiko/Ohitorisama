class AddRateAverageToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :rate_average, :float
  end
end
