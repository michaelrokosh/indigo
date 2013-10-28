class Post < ActiveRecord::Base

	has_many :comments, dependent: :destroy
	validates :title, presence: true, 
	                  length: { minimum: 3 }
	validates :content, presence: true
	acts_as_voteable
	acts_as_taggable
end
