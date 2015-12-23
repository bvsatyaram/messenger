class CreateConversationThreads < ActiveRecord::Migration
  def change
    create_table :conversation_threads do |t|

      t.timestamps null: false
    end
  end
end
