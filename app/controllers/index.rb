get '/' do
  erb :index
end

post '/tweets' do
  # TwitterUser.n()
  username = params[:username]


  twitter_user = TwitterUser.find_or_initialize_by_username(username)
  # twitter_user = TwitterUser.where("username=?", username).first_or_initialize

  if twitter_user.tweets.empty?
    most_recent_tweets = Twitter.user_timeline("@#{username}")

    most_recent_tweets.each do |tweet|
      twitter_user.tweets.build(text: tweet.text, tweet_id: tweet.id, tweet_date: tweet.created_at)
    end
    twitter_user.save  
  end

  @tweets = twitter_user.tweets

  if request.xhr?
    erb :_render_tweets, :layout => false, :locals => {tweets: @tweets}
  else
    erb :_render_tweets, :layout => true, :locals => {tweets: @tweets}
  end  
end



# if timestamp of latest tweet on site equals timestamp of latest tweet in db
# dont do anything, else update db and delete the latest


# timer funtion
#  checked = Time.now
# if checked = today -- > fine

# else update


# Twitter.user_timeline(usdername, number of tweets = 20)
