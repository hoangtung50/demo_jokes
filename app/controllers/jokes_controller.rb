class JokesController < ApplicationController

  before_action :set_cookies
  before_action :set_joke, only: [:index]

  def index
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @vote = Vote.new
    @vote.joke_id = params[:joke_id]
    @vote.like = params[:like]
    @vote.user_id = params[:user_id]
    @vote.save!

    set_joke
  end

  private

  def set_joke
    # check if not vote all joke then show more other
    # else show "That's all the jokes for today! Come back another day!"
    # select joke not in joke voted ids
    @joke = Joke.where.not(id: Vote.get_joke_ids_for_user_id(cookies[:user_id])).first
  end

  def set_cookies
    cookies[:user_id] ||= SecureRandom.hex
  end
end
