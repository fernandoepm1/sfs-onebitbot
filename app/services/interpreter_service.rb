class InterpreterService
  def self.call(action, params)
    case action
    when 'create'
      FaqManager::CreateService.call(params)
    when 'list', 'search', 'search_by_hashtag'
      FaqManager::ListService.call(action, params)
    when 'remove'
      FaqManager::RemoveService.call(params)
    when 'help'
      FaqManager::HelpService.call
    else
      'Come again?'
    end
  end
end
