class CreateConversationMessageSubscriptions < ActiveRecord::Migration
  def change
    create_table :conversation_message_subscriptions do |t|
      t.references :message, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
