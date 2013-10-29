class Vote < ActiveRecord::Base

  scope :for_voter, lambda { |*args| where(["voter_id = ? AND voter_type = ?", args.first.id, args.first.class.base_class.name]) }
  scope :for_voteable, lambda { |*args| where(["voteable_id = ? AND voteable_type = ?", args.first.id, args.first.class.base_class.name]) }
  scope :recent, lambda { |*args| where(["created_at > ?", (args.first || 2.weeks.ago)]) }
  scope :descending, lambda { order("created_at DESC") }

  belongs_to :voteable, :polymorphic => true
  belongs_to :voter, :polymorphic => true

  attr_accessible :vote, :voter, :voteable if ActiveRecord::VERSION::MAJOR < 4


  # Comment out the line below to allow multiple votes per user.
  validates_uniqueness_of :voteable_id, :scope => [:voteable_type, :voter_type, :voter_id]

  after_create :update_comment_rating

    def update_comment_rating
    	self.voteable.rating = self.voteable.plusminus
      self.voteable.save
      #self.voteable.user.karma += self.voteable.plusminus
      #self.voteable.user.save
    end

  after_create :update_user_karma
    def update_user_karma
      self.voteable.user.karma = self.voteable.user.comments.pluck(:rating).sum
      self.voteable.user.save
    end

end
