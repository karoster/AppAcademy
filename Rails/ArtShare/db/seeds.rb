# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all


u1 = User.create!(name: "Karl", email: "karl@gmail.com")
u2 = User.create!(name: "Kat", email: "kat@gmail.com")
u3 = User.create!(name: "Ross", email: "ross@gmail.com")


a1_1 = Artwork.create!(title: "Karl_Magnum_Opus1", image_url: "google1.com", artist_id: u1.id)
a1_2 = Artwork.create!(title: "Karl_Magnum_Opus2", image_url: "google2.com", artist_id: u1.id)
a1_3 = Artwork.create!(title: "Karl_Magnum_Opus3", image_url: "google3.com", artist_id: u1.id)

a2_1 = Artwork.create!(title: "Kat_Magnum_Opus1", image_url: "reddit1.com", artist_id: u2.id)
a2_2 = Artwork.create!(title: "Kat_Magnum_Opus2", image_url: "reddit2.com", artist_id: u2.id)
a2_3 = Artwork.create!(title: "Kat_Magnum_Opus3", image_url: "reddit3.com", artist_id: u2.id)


a3_1 = Artwork.create!(title: "Ross_Magnum_Opus1", image_url: "youtube1.com", artist_id: u3.id)
a3_2 = Artwork.create!(title: "Ross_Magnum_Opus2", image_url: "youtube2.com", artist_id: u3.id)
a3_3 = Artwork.create!(title: "Ross_Magnum_Opus3", image_url: "youtube3.com", artist_id: u3.id)


as1 = ArtworkShare.create!(viewer_id: u1.id, artwork_id: a3_1.id)
as2 = ArtworkShare.create!(viewer_id: u2.id, artwork_id: a3_1.id)
as3 = ArtworkShare.create!(viewer_id: u3.id, artwork_id: a3_1.id)

as3 = ArtworkShare.create!(viewer_id: u2.id, artwork_id: a1_3.id)
as3 = ArtworkShare.create!(viewer_id: u1.id, artwork_id: a1_3.id)
as3 = ArtworkShare.create!(viewer_id: u3.id, artwork_id: a1_3.id)

c1 = Comment.create!(user_id: u2.id, artwork_id: a2_1.id, body: "Not my best work, imo...")
c2 = Comment.create!(user_id: u1.id, artwork_id: a2_1.id, body: "I think its great!")
c3 = Comment.create!(user_id: u2.id, artwork_id: a2_1.id, body: "Complete trash...")

