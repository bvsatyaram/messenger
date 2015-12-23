class Conversation::Thread < ActiveRecord::Base
  has_many :subscriptions, class_name: Conversation::ThreadSubscription.name, dependent: :destroy
  has_many :messages, class_name: Conversation::Message.name, dependent: :destroy

  def self.between(usr1, usr2)
    thread_ids1 = Conversation::ThreadSubscription.where(user_id: usr1.id).pluck(:thread_id)
    subscription =  Conversation::ThreadSubscription.where(
      user_id: usr2.id,
      thread_id: thread_ids1
    ).first
    if subscription
      return subscription.thread
    else
      thread = Conversation::Thread.new
      thread.subscribe(usr1)
      thread.subscribe(usr2)
      return thread
    end
  end

  def subscribe(usr)
    self.subscriptions.find_or_initialize_by(user_id: usr.id)
  end
end
