class Conversation::ThreadsController < ApplicationController
  def index
    @threads = Conversation::Thread.all
  end

  def show
    @thread = Conversation::Thread.find(params[:id])
    @messages = @thread.messages_for_user(current_user)
  end
end
