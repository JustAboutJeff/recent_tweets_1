get '/' do
  erb :index
end

post '/tweets' do
  # TwitterUser.n()
  username = params[:username]


  twitter_user = TwitterUser.find_or_initialize_by_username(username)
  # twitter_user = TwitterUser.where("username=?", username).first_or_initialize

  if twitter_user.tweets.empty? # BUILD NEW USER AND THEIR TWEETS
    most_recent_tweets = Twitter.user_timeline("@#{username}")
    most_recent_tweets.each do |tweet|
      twitter_user.tweets.build(text: tweet.text, tweet_id: tweet.id, tweet_date: tweet.created_at)
    end
  elsif twitter_user.stale? # UPDATE USER TWEETS
    twitter_user.tweets.destroy
    most_recent_tweets = Twitter.user_timeline("@#{username}")
    most_recent_tweets.each do |tweet|
      twitter_user.tweets.build(text: tweet.text, tweet_id: tweet.id, tweet_date: tweet.created_at)
    end
  end

  twitter_user.save 
  @tweets = twitter_user.tweets

  if request.xhr?
    erb :_render_tweets, :layout => false, :locals => {tweets: @tweets}
  else
    erb :_render_tweets, :layout => true, :locals => {tweets: @tweets}
  end  
end
