class Conversation::ThreadsController < ApplicationController
  def index
    @threads = Conversation::Thread.all
  end
end
