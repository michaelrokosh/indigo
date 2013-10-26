class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_many :votes, :through => :comments
  validates :username, :presence => true 

	def karma
		self.votes.sum(:score)
	end

  def positive_votes
    self.votes.sum(:score, :conditions => 'score > 0')
  end

  def negative_votes
    self.votes.sum(:score, :conditions => 'score < 0')
  end
end
