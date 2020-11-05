require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'validations' do
    subject { User.create(name: 'A random user', email: 'Arandom@test.com', id: 1) }
    subject { Post.create(content: 'This is a post for testing purpose', id: 1) }
    subject { Like.create(user_id: 1, post_id: 1) }

    it { should validate_uniqueness_of(:post_id) }
  end
end
