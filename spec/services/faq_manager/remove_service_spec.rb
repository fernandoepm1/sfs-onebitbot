require_relative './../../spec_helper.rb'

describe FaqManager::RemoveService do
  describe '#call' do
    context 'when id is valid' do
      before do
        faq = create(:faq)
      end

      it 'returns success message' do
        response = FaqManager::RemoveService.call({ id: faq.id })

        expect(response).to match("Successfully removed.")
      end

      it 'removes faq from database' do
        expect(Faq.all.count).to eq(1)
        FaqManager::RemoveService.call({ id: faq.id })
        expect(Faq.all.count).to eq(0)
      end
    end

    context 'when id is invalid' do
      it 'returns error message' do
        response = FaqManager::RemoveService.call({ id: rand(1..99) })

        expect(response).to match("Invalid id.")
      end
    end
  end
end