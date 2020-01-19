require_relative './application_service.rb'

class TranslatorService < ApplicationService
  def initialize(params)
    @params = params
  end

  def call
    begin
      @translate_api_url = ENV['TRANSLATE_API_URL']
      @translate_api_key = ENV['TRANSLATE_API_KEY']

      request_url = "#{@translate_api_url}/api/v1.5/tr.json/translate"
      request_url << "?key=#{@translate_api_key}"
      request_url << "&text=#{@params['text']}"
      request_url << "&lang=#{@params['lang']}" #=> lang=ru or lang=en-ru

      response = RestClient.get(request_url)
      translated_text = JSON.parse(response.body)['text'][0]
    rescue RestClient::ExceptionWithResponse => exception
      exception.response
    end
  end

  private
    def get_all_symbols
      begin
        request_url = "#{@translate_api_url}/api/"
        response = RestClient.get(request_url)
      rescue RestClient::ExceptionWithResponse => exception
      end
    end
end
