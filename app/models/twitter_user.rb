class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def stale?
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

end


