class Conversation::MessagesController < ApplicationController
  def new
    @message = Conversation::Message.new
  end

  def create
    @message = Conversation::Message.new(message_params)
    receiver = User.find_by(email: @message.email)
    if receiver.nil?
      flash[:alert] = "Please check the email you have entered"
      render :new
    else
      @message.thread = current_user.conversation_thread_with(receiver)
      @message.author = current_user
      @message.save!
      redirect_to conversation_threads_path
    end
  end

private
  def message_params
    params.require(:conversation_message).permit(:email, :content)
  end
end
