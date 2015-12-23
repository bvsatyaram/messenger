class Conversation::Message < ActiveRecord::Base
  belongs_to :thread, class_name: Conversation::Thread.name
  belongs_to :author, class_name: User.name

  attr_accessor :email
end
