class InterpreterService < ApplicationService
  def call(action, params)
    case action
    when 'create'
      FaqManager::CreateService.call(params)
    when 'list', 'search', 'search_by_hashtag'
      FaqManager::ListService.call(params, action)
    when 'remove'
      FaqManager::RemoveService.call(params)
    when 'help'
      FaqManager::HelpService.call(params)
    else
      'Come again?'
    end
  end
end
