module FaqManager
  class ListService < ApplicationService
    def initialize(params, action)
      @query  = params[:query]
      @action = action
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
