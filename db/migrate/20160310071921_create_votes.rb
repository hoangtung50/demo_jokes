class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :joke
      t.string :user_id
      t.boolean :like
      t.timestamps null: false
    end
  end
end
