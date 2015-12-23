class Conversation::ThreadSubscription < ActiveRecord::Base
  belongs_to :thread, class_name: Conversation::Thread.name
  belongs_to :user
end
