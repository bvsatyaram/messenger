class Conversation::MessageSubscription < ActiveRecord::Base
  belongs_to :message
  belongs_to :user

  after_destroy :destroy_message_if_orphan

private
  def destroy_message_if_orphan
    message.destroy! if self.message.reload.subscriptions.count == 0
  end
end
