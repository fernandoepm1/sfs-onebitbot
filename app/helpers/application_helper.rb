module ApplicationHelper
  def default_fallback_response(language)
    case language
    when 'pt-br'
      [
        'Como é?',
        'Não entendi muito bem o que você quis dizer.',
        'Não deu certo processar o que foi dito.',
        'Poderia tentar novamente mais tarde?',
        'Tente novamente mais tarde.',
        'Por gentileza, tente de novo daqui a pouco.',
        'Desculpe, não estava atento, poderia repetir?',
        'Perdão, não consegui entender.',
        'Poderia mandar novamente? Não entendi muito bem.',
        'Perdão, estava um pouco ocupado, poderia repetir?'
      ].sample
    else
      [
        'Come again?',
        'Sorry, I didn\'t get that.',
        'Can you try again later?',
        'I couldn\'t process that.',
        'Could you try again in a minute or so?',
        'Forgive me, I was a little busy, can you say that again?',
        'Excuse me, could you repeat that?'
      ].sample
    end
  end
end
