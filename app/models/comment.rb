class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  belongs_to :user
  has_many :votes
  acts_as_taggable
end
