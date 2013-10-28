class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  validates :username, :presence => true 
  acts_as_voter

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
