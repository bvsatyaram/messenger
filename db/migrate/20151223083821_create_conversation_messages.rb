class CreateConversationMessages < ActiveRecord::Migration
  def change
    create_table :conversation_messages do |t|
      t.references :thread, index: true, foreign_key: true
      t.references :author, index: true, foreign_key: true
      t.string :content

      t.timestamps null: false
    end
  end
end
