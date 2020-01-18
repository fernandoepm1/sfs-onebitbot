require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

# Load models
Dir['./app/models/*.rb'].each { |file| require file }
Dir['./app/services/**/*.rb'].each { |file| require file }

class App < Sinatra::Base
  get '/' do
    'Hello World!'
  end

  post '/webhook' do
    request.body.rewind
    result = JSON.parse(request.body.read)['queryResult']

    response =
      if result['contexts'].present?
        InterpreterService.call(result['action'], result['contexts'][0]['parameters'])
      else
        InterpreterService.call(result['action'], result['parameters'])
      end

    content_type :json, charset: 'utf-8'
    {
      "fulfillmentText": response,
      "payload": {
        "telegram": {
          "text": response,
          "parse_mode": "Markdown"
        }
      }
    }.to_json
  end
end
