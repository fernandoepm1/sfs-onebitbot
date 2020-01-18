require_relative './../../spec_helper.rb'

describe FaqManager::HelpService do
  describe '#call' do
    it 'returns the main commands' do
      response = FaqManager::HelpService.call()

      expect(response).to match('help')
      expect(response).to match('add faq')
      expect(response).to match('remove faq [id]')
      expect(response).to match('what do you know about []')
      expect(response).to match('search hashtag []')
      expect(response).to match('list all faqs')
    end
  end
end