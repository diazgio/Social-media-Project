require 'rails_helper'
require './app/models/post.rb'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    subject { Post.create(content: 'This is a post for testing purpose') }

    it { should validate_presence_of(:content) }
  end
end
