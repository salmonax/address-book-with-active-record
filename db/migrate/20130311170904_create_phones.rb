class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.column :phone, :string
    end
  end
end
