require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

# Load models
Dir['./app/models/*.rb'].each { |file| require file }
Dir['./app/services/**/*.rb'].each { |file| require file }

class App < Sinatra::Base
  before do
    request.body.rewind
    @request_payload = ActiveSupport::JSON.decode(request.body.read)
  end

  get '/' do
    'Hello World!'
  end

  post '/webhook' do
    result = @request_payload['queryResult'] if @request_payload['queryResult'].present?

    response =
      if result['outputContexts'].present?
        InterpreterService.call(result['action'], result['outputContexts'][0]['parameters'])
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
