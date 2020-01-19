class InterpreterService < ApplicationService
  def initialize(action, params, language)
    @action   = action
    @params   = params
    @language = language
  end

  def call
    case @action
    when 'translate'
      TranslatorService.call(@params)
    when 'create'
      FaqManager::CreateService.call(@params)
    when 'list', 'search', 'search_by_hashtag'
      FaqManager::ListService.call(@action, @params)
    when 'remove'
      FaqManager::RemoveService.call(@params)
    when 'help'
      FaqManager::HelpService.call
    else
      default_fallback_response(@language)
    end
  end
end
