class AddContactStatusToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :contact_status, :integer, null: false, default: 0
  end
end
