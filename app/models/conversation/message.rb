class Conversation::Message < ActiveRecord::Base
  belongs_to :thread, class_name: Conversation::Thread.name
  belongs_to :author, class_name: User.name
  has_many :subscriptions, class_name: Conversation::MessageSubscription.name, dependent: :destroy

  attr_accessor :email

  after_create :subscribe_users
  after_destroy :destroy_thread_if_orphan

  def subscription_of(usr)
    self.subscriptions.find_by(user_id: usr.id)
  end

  def subscribe(usr)
    self.subscriptions.find_or_create_by(user_id: usr.id)
  end

private
  def subscribe_users
    self.thread.subscriptions.collect(&:user).each do |usr|
      self.subscribe(usr)
    end
  end

  def destroy_thread_if_orphan
    self.thread.destroy! if self.thread.reload.messages.count == 0
  end
end
