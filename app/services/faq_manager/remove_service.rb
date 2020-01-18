require_relative './../application_service.rb'

module FaqManager
  class RemoveService < ApplicationService
    def initialize(params)
      @id = params[:id]
    end

    def call
      faq = Faq.find(@id)
      return 'Question not found, check id.' if faq.nil?

      Faq.transaction do
        faq.hashtags.each do |hashtag|
          if hashtag.faqs.count <= 1
            hashtag.delete
          end
        end
        faq.delete
        'Faq successfully deleted.'
      end
    end
  end
end
