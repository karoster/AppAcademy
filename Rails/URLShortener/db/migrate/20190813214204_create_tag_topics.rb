class CreateTagTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_topics do |t|
    	t.text :tag
    end

    add_index(:tag_topics, :tag, unique: true)
  end
end
