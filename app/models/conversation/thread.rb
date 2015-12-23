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
      thread.save!
      return thread
    end
  end

  def subscribe(usr)
    self.subscriptions.find_or_initialize_by(user_id: usr.id)
  end

  def excerpt
    self.messages.last.content
  end

  def other_participant(usr)
    self.subscriptions.where.not(user_id: usr.id).first.user
  end

  def messages_for_user(usr)
    msgs = self.messages
    ids_to_display = Conversation::MessageSubscription.where(
      user_id: usr.id,
      message_id: msgs.collect(&:id)
    ).pluck(:message_id)

    return msgs.select{|msg| ids_to_display.include?(msg.id)}
  end
end
