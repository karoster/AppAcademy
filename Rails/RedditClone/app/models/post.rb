class Post < ApplicationRecord
    validates :title, presence: true
    validates :subs, presence: {message: "must be present"}

    belongs_to :author,
        foreign_key: :author_id,
        primary_key: :id,
        class_name: "User",
        dependent: :destroy


    # belongs_to :sub,
    #     foreign_key: :sub_id,
    #     primary_key: :id

    has_many :sub_posts,
        foreign_key: :post_id,
        primary_key: :id,
        class_name: "PostSub",
        inverse_of: :post

        
    has_many :subs,
        through: :sub_posts,
        source: :sub

    has_many :comments,
        foreign_key: :post_id,
        primary_key: :id,
        class_name: "Comment"

    def comments_by_parent_id
        all_post_comments = self.comments.includes(:author)
        hash_by_parent_id = Hash.new { |h,k| h[k] = [] }
        all_post_comments.each do |comment|
            hash_by_parent_id[comment.parent_comment_id] += [comment]
        end
        hash_by_parent_id
    end

end