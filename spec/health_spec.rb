require 'rack/test'
require 'json'
require 'sinatra/base'
require_relative '../app/controllers/application_controller'

RSpec.describe 'Health Endpoint' do
  include Rack::Test::Methods
  def app
    ApplicationController.new
  end

  it 'returns ok status and current timestamp' do
    get '/health'
    expect(last_response.status).to eq(200)

    body = JSON.parse(last_response.body)
    expect(body['status']).to eq('ok')
    expect(body).to have_key('time')
  end
end
