require_relative './../application_service.rb'

module FaqManager
  class CreateService < ApplicationService
    def initialize(params)
      @question = params['question']
      @answer   = params['answer']
      @hashtags = params['hashtags']
    end

    def call
      return 'Hashtag not found' if @hashtags.nil?

      Faq.transaction do
        faq = Faq.create(question: @question, answer: @answer)
        @hashtags.split(/[\s,]+/).each do |hashtag|
          faq.hashtags << Hashtag.find_or_create_by(name: hashtag)
        end
      end
      'Faq successfully created.'
    end
  end
end
