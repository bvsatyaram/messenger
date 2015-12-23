class Conversation::MessageSubscriptionsController < ApplicationController
  def destroy
    @message_subscription = Conversation::MessageSubscription.find(params[:id])
    @message_subscription.destroy!
  end
end
