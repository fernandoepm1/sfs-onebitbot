require_relative './../application_service.rb'

module FaqManager
  class ListService < ApplicationService
    def initialize(action, params)
      @action = action
      @query  = params[:query]
    end

    def call
      faqs =
        if @action == 'search'
          Faq.search(@query)
        elsif @action == 'search_by_hashtag'
          Faq.joins(:hashtags).where(hashtags: { name: @query })
        else
          Faq.all
        end

      response = "Faqs \n\n"
      faqs.each do |faq|
        response << "*#{faq.id}. #{faq.question}* \n"
        response << "`#{faq.answer}` \n"
        faq.hashtags.each do |hashtag|
          response << "_##{hashtag.name}_ "
        end
        response << "\n\n"
      end
      (faqs.count > 0) ? response : "Nothing was found."
    end
  end
end
