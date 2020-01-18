require_relative './../../spec_helper.rb'

describe FaqManager::ListService do
  describe '#call' do
    context 'list command' do
      context 'no faqs in database' do
        it 'gives not found message' do
          response = FaqManager::ListService.call({}, 'list')

          expect(response).to match("No faqs were found.")
        end
      end

      context 'two faqs in database' do
        it 'show all faqs' do
          faq1 = create(:faq)
          faq2 = create(:faq)

          response = FaqManager::ListService.call({}, 'list')

          expect(response).to match(faq1.question)
          expect(response).to match(faq1.answer)
          expect(response).to match(faq2.question)
          expect(response).to match(faq2.answer)
        end
      end
    end

    context 'search command' do
      context 'empty query' do
        it 'returns not found message' do
          response = FaqManager::ListService.call({ query: '' }, 'search')

          expect(response).to match("No matches were found.")
        end
      end

      context 'valid query' do
        it 'returns question and answer' do
          faq = create(:faq)

          response = FaqManager::ListService.call({ query: faq.question.split(" ").sample }, 'search')

          expect(response).to match(faq.question)
          expect(response).to match(faq.answer)
        end
      end
    end

    context 'search by hashtag command' do
      context 'invalid hashtag' do
        it 'returns not found message' do
          response = FaqManager::ListService.call({ query: '' }, 'search_by_hashtag')

          expect(response).to match("No matches were found")
        end
      end

      context 'valid hashtag' do
        it 'finds question and answer' do
          faq = create(:faq)
          hashtag = create(:hashtag)
          create(:faq_hashtag, faq: faq, hashtag: hashtag)

          response = FaqManager::ListService.call({ query: hashtag.name }, 'search_by_hashtag')

          expect(response).to match(faq.question)
          expect(response).to match(faq.answer)
        end
      end
    end
  end
end