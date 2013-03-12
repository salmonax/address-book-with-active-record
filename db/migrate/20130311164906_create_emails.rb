class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.column :email, :string

    end
  end
end
