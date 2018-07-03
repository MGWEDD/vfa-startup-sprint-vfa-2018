require_relative 'config/environment'

class App < Sinatra::Base
  get '/' do
    @error = params['error']
    erb :home
  end

  # SUBSCRIBE FEATURE
  post '/subscribe' do
    @full_name = params[:full_name]
    @email = params[:email]

    if !@email.match(/.+@.+/)
      redirect to('/?error=email')
    end

    erb :subscribe
  end

# REDDIT FEATURE
  get '/reddit' do
    
    # get json as ruby object, then write html to view some of it.
    reddit_json_ruby = JSON.parse(RestClient.get('http://reddit.com/.json'))
    
    # master erb array object with n (3 now) reddit posts from the reddit API
    
    @post_one = reddit_json_ruby['data']['children'][0], 
    @post_two = reddit_json_ruby['data']['children'][1],
    @post_three = reddit_json_ruby['data']['children'][2]
    
    @reddit_posts = [@post_one, @post_two, @post_three]
    
    binding.pry
    
    erb :reddit
  end

  # SCHEDULE FEATURE
  get '/schedule' do
    @today = [
      ['7:00am', 'Wake up'],
      ['8:00am', 'Work Out'],
      ['9:00am', 'Product Meeting'],
      ['11:00am', 'Ping Pong Break'],
      ['1:00pm', 'Lunch'],
      ['3:00pm', 'Coffee Time'],
      ['6:30pm', 'Call it a day'],
    ]

    @tomorrow = [
      ['7:00am', 'Wake up'],
      ['8:00am', 'Work Out'],
      ['9:00am', 'Inbox Zero'],
      ['11:00am', 'Ping Pong Break'],
      ['1:00pm', 'Lunch'],
      ['3:00pm', 'Coffee Time'],
      ['6:30pm', 'Meetup Presentation'],
    ]

    # TODO: add a third day's schedule (@day_after)

    erb :schedule
  end

  # TODO: design and implement /training page

  # TODO: add /team page

  # TODO: add /video page

  # TODO: add /rainbow easter egg page
end
