class JokesController < ApplicationController

  before_action :set_session
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

    # add to joke_voted_ids when user vote joke
    session[:joke_voted_ids] << params[:joke_id].to_i

    set_joke
  end

  private

  def set_joke
    # check if not vote all joke then show more other
    # else show "That's all the jokes for today! Come back another day!"
    # select joke not in joke_voted_ids
    @joke = Joke.where.not(id: session[:joke_voted_ids]).first
  end

  def set_session
    session[:user_id] ||= SecureRandom.hex
    # list ids joke voted
    session[:joke_voted_ids] ||= []
  end
end
