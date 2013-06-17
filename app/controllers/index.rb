get '/' do
  erb :index
end

post '/tweets' do
  # TwitterUser.n()
  @tweets = Twitter.user_timeline("@#{params[:username]}")
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
