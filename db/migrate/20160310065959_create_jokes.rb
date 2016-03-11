class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.column :name, :string
      t.column :content, :text

      t.timestamps null: false
    end
  end
end
