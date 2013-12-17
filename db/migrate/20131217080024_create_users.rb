class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.datetime :birthday
      t.string :gender
      t.string :address
      t.string :company
      t.timestamps
    end
  end
end