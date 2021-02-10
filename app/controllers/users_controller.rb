class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, expect: [:show]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.preload(:theater, :movie, :stage).order(updated_at: :desc)
  end

  def update
    @user.update_without_password(user_params)
    redirect_to mypage_users_path
  end

  def mypage; end

  def update_password
    if password_set?
      if @user.update_password(user_params)
        flash[:notice] = 'パスワードは正しく更新されました'
        redirect_to mypage_users_path
      else
        flash[:alert] = 'パスワードを6文字以上で入力してください'
        render 'edit_password'
      end
    else
      @user.errors.add(:password, 'パスワードが一致しません')
      render 'edit_password'
    end
  end

  def edit_password; end

  def favorite
    @theaters = @user.likees(Theater.preload(:country, :reviews).order(updated_at: :desc))
    @movies = @user.likees(Movie.preload(:country, :reviews).order(updated_at: :desc))
    @stages = @user.likees(Stage.preload(:theater, :reviews).order(updated_at: :desc))
    @theater_review = current_user.reviews.theaters(@theaters)
    @movie_review = current_user.reviews.movies(@movies)
    @stage_review = current_user.reviews.stages(@stages)
  end

  def review
    @reviews = @user.reviews
    @reviews_theater = @reviews.set_theaters
    @reviews_movie = @reviews.set_movies
    @reviews_stage = @reviews.set_stages
    @likes_theater = @user.likees(Review.set_theaters)
    @likes_movie = @user.likees(Review.set_movies)
    @likes_stage = @user.likees(Review.set_stages)
  end

  def destroy
    @user.deleted_flg = User.switch_flg(@user.deleted_flg)
    @user.save
    sign_out(@user)
    redirect_to root_path, notice: '退会処理が完了しました'
  end

  private

  def user_params
    params.permit(:name, :email, :birthday, :sex, :profile, :password, :password_confirmation, :deleted_flg, :image)
  end

  def set_user
    @user = current_user
  end

  def password_set?
    user_params[:password].present? && user_params[:password_confirmation].present? ? true : false
  end
end
