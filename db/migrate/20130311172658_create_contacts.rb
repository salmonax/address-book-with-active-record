

class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :kind, :string
      t.timestamps
    end  

    add_column :emails, :contact_id, :integer
    add_column :emails, :kind, :string
    add_column :phones, :contact_id, :integer
    add_column :phones, :kind, :string
    add_column :addresses, :contact_id, :integer
    add_column :addresses, :kind, :string

  end
end
