class RemoveIndexLongUrlFromShortenedUrl < ActiveRecord::Migration[5.1]
  def change
  	remove_index :shortened_urls, column: :long_url, unique:true 
  end
end
