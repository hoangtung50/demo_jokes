require "rails_helper"

RSpec.describe "routes for Jokes", :type => :routing do
  it "routes /jokes to the jokes controller" do
    expect(get("/jokes")).
        to route_to("jokes#index")
  end

  it "routes /jokes/create to the /create action" do
    expect(post("/jokes")).
        to route_to("jokes#create")
  end
end