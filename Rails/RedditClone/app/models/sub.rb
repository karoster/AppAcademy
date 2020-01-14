class Sub < ApplicationRecord
    validates :title, :description, :creator_id, presence: true
    validates :title, uniqueness: true

    has_one :moderator,
        foreign_key: :creator_id,
        class_name: "User"
        
    has_many :sub_posts,
        foreign_key: :sub_id,
        primary_key: :id,
        class_name: "PostSub",
        dependent: :destroy

    has_many :posts,
        through: :sub_posts,
        source: :post

end