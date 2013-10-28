class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  belongs_to :user
  acts_as_taggable
  acts_as_voteable
end
