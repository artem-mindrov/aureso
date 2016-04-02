class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.string :body, null: false
      t.references :user, index: true, foreign_key: true
      t.datetime :last_used_at
      t.string :ip, null: false
      t.string :user_agent, null: false

      t.timestamps
    end
  end
end
