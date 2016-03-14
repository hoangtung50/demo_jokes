require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should respond_to(:joke_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:like) }
  it { should be_valid }
end
