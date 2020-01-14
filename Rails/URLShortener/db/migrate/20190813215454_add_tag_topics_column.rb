class AddTagTopicsColumn < ActiveRecord::Migration[5.1]
  def change
  	add_column :tag_topics, :tag, :text
  end
end
