class Like < Socialization::ActiveRecordStores::Like
  has_one :post, dependent: :destroy

  after_commit :create_post, on: [:create]

  private

  def create_post
    post = Post.new(like_id: id, user_id: liker_id)
    case likeable_type
    when 'Theater'
      post.theater_id = likeable_id
    when 'Movie'
      post.movie_id = likeable_id
    when 'Stage'
      post.stage_id = likeable_id
    when 'Review'
      post.review_id = likeable_id
    end
    post.save
  end
end
