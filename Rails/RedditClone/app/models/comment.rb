class Comment < ApplicationRecord
    validates :author_id, :post_id, :content, presence: true
    belongs_to :author, foreign_key: :author_id, class_name: "User"
    belongs_to :post, foreign_key: :post_id, primary_key: :id, class_name: "Post"

    has_many :child_comments,
        foreign_key: :parent_comment_id,
        primary_key: :id,
        class_name: "Comment"


end