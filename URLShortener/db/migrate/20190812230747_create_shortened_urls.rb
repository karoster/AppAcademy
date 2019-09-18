class CreateShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shortened_urls do |t|
    	t.text :short_url
    	t.text :long_url
    	t.integer :user_id

    	t.timestamps
    end
    add_index(:shortened_urls, :short_url, unique: true)
    add_index(:shortened_urls, :long_url, unique: true)
  end
end
