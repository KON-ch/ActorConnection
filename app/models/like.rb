class Like < Socialization::ActiveRecordStores::Like
  has_one :post, dependent: :destroy

  after_commit :create_post, on: [:create]

  private
    def create_post
      post = Post.new(like_id: self.id, user_id: self.liker_id)
      if self.likeable_type == "Theater"
        post.theater_id = self.likeable_id
      elsif self.likeable_type == "Movie"
        post.movie_id = self.likeable_id
      elsif self.likeable_type == "Stage"
        post.stage_id = self.likeable_id
      elsif self.likeable_type == "Review"
        post.review_id = self.likeable_id
      end
      post.save
    end
end
