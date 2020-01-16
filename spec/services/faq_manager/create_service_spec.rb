require_relative './../../spec_helper.rb'

describe FaqManager::CreateService do
  before do
    @question = FFaker::Lorem.sentence
    @answer = FFaker::Lorem.sentence
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  describe '#call' do
    context 'when params are invalid' do
      it 'gives an error' do
        response = FaqManager::CreateService.call({ question: @question, answer: @answer })
        expect(response).to match("Hashtag obrigatória")
      end
    end

    context 'when params are valid' do
      before do
        @response = FaqManager::CreateService.call(
          { question: @question, answer: @answer, hashtags: @hashtags }
        )
      end

      it 'gives success message' do
        expect(@response).to match("Successfully created Faq!")
      end

      it 'creates faq in database' do
        expect(Faq.last.question).to match(@question)
        expect(Faq.last.answer).to match(@answer)
      end

      it 'creates hashtags in database' do
        expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
        expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
      end
    end
  end
end