require 'sinatra/base'
require 'sinatra/flash'
require 'json'
require 'time'

class ApplicationController < Sinatra::Base

  set :protection, except: :path_traversal

  before do
    puts "➡ Path: #{request.path_info}"
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions, true
    set :session_secret, ENV["SESSION_SECRET"] || "a" * 64
    set :method_override, true
    register Sinatra::Flash

    disable :protection if ENV['RACK_ENV'] == 'test'
  end


  before do
    # Skip protection for the /health route only
    if request.path_info == '/health'
      env['rack.protection'].except!(:authenticity_token) if env['rack.protection']
    end
  end

  get "/" do
    @posts = Post.all
    erb :"/posts/index.html"
  end

  not_found do
    flash[:error] = "Whoops! Couldn't find that route"
    redirect "/posts"
  end

  private

  def current_user
    User.find_by_id(session[:id])
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_not_logged_in
    unless logged_in?
      flash[:error] = "You must be logged in to view that page"
      redirect request.referrer || "/login"
    end
  end

  # Health check endpoint — should bypass auth/CSRF
  get '/health' do
    headers 'Cache-Control' => 'no-cache, no-store, must-revalidate'
    content_type :json
    status 200
    {
      status: 'ok',
      time: Time.now.utc.iso8601
    }.to_json
  end
end
