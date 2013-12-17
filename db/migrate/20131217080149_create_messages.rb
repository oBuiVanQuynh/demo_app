class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.interger :user_id
      t.interger :friend_id
      t.string :content

      t.timestamps
    end
  end
end
