require 'rails_helper'

RSpec.describe JokesController, type: :controller do

  before do
    cookies[:user_id] = SecureRandom.hex
  end

  describe "GET index" do
    it "with user read first joke then assigns joke as @joke is first joke" do
      get :index
      expect(assigns(:joke)).to eq(Joke.first)
      expect(Vote.get_joke_ids_for_user_id(cookies[:user_id])).to eq([])
    end

    it "with user voted first joke and read second joke then assigns joke as @joke is second joke" do
      Vote.should_receive(:get_joke_ids_for_user_id).with(cookies[:user_id]).and_return([Joke.first.id])
      get :index
      expect(assigns(:joke)).to eq(Joke.first(2)[1])
    end

    it "with user voted all joke then assigns joke as @joke is nil" do
      Vote.should_receive(:get_joke_ids_for_user_id).with(cookies[:user_id]).and_return(Joke.ids)
      get :index
      expect(assigns(:joke)).to eq(nil)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
