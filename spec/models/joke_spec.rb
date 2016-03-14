require 'rails_helper'

RSpec.describe Joke, type: :model do

  it { should respond_to(:name) }
  it { should respond_to(:content) }
  it { should be_valid }
end
