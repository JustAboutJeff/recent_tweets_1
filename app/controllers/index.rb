get '/' do
  erb :index
end

post '/tweets' do
  username = params[:username]
  twitter_user = TwitterUser.find_or_initialize_by_username(username)

  if twitter_user.stale? # UPDATE A USERS TWEET CACHE
    twitter_user.refresh
    twitter_user.save 
  end

  @tweets = twitter_user.tweets

  if request.xhr?
    erb :_render_tweets, :layout => false, :locals => {tweets: @tweets}
  else
    erb :_render_tweets, :layout => true, :locals => {tweets: @tweets}
  end  
end
