class AddCounterToPosts < ActiveRecord::Migration

  def self.up
    add_column :posts, :comments_count, :integer, :default => 0
     Post.find_each do |post|
      post.update_attribute(:comments_count, post.comments.length)
      post.save
    end
  end

  def self.down
    remove_column :posts, :comments_count
  end
end