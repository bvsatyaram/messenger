class Conversation::ThreadsController < ApplicationController
  def index
    @threads = Conversation::Thread.all
  end

  def show
    @thread = Conversation::Thread.find(params[:id])
    @messages = @thread.messages
  end
end
