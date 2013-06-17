class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.references :twitter_user
      t.timestamp :tweet_date
      t.string :tweet_id
      t.timestamps
    end  
  end
end
