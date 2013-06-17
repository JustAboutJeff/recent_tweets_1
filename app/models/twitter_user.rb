class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def stale?
    return true if self.tweets.empty?
    tweets = self.tweets.order('created_at DESC')
    tweet_freq = self.tweet_freq(tweets)
    (tweets.last.tweet_date.to_f >= (Time.now.to_f - tweet_freq))
  end

  def tweet_freq(tweets)
    difference = 0
    tweets.each_with_index do |tweet, index|
        difference += tweets[index+1].tweet_date.to_f - tweet.tweet_date.to_f unless index = tweets.count
      end 
    (difference / (tweets.count-1).to_f)
  end

  def refresh
    self.tweets.destroy
    most_recent_tweets = Twitter.user_timeline("@#{self}")
    most_recent_tweets.each do |tweet|
      self.tweets.build(text: tweet.text, tweet_id: tweet.id, tweet_date: tweet.created_at)
    end
  end 

end


