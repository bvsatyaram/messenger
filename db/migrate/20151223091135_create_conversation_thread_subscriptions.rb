class CreateConversationThreadSubscriptions < ActiveRecord::Migration
  def change
    create_table :conversation_thread_subscriptions do |t|
      t.references :thread, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
