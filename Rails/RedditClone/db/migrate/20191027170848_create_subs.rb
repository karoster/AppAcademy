class CreateSubs < ActiveRecord::Migration[6.0]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :creator_id, null: false
      t.timestamps
    end
    add_index :subs, :title, unique: true
    add_index :subs, :creator_id, unique: true
  end
end
