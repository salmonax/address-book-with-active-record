class CreateAddresses < ActiveRecord::Migration
  def change
     create_table :addresses do |t|
      t.column :address, :string
   
    end
  end
end
