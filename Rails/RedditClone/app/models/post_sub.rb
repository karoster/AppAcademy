class PostSub < ApplicationRecord
    validates :sub_id, uniqueness: {scope: :post_id, message: "should happen once per sub"}
    validates :post, :sub_id, presence: true
    belongs_to :sub
    belongs_to :post

end