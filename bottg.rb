require 'telegram/bot'
require './test.rb'
require './parserexcel.rb'

token = '1010148951:AAFCVQ9oeZZlPBEvW-_FIPYFicf24wKFg_U'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
    	indroduceText = 'select your day'
    	daySelect = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [%w(Today), %w(Tomorrow)], one_time_keyboard: false)

    bot.api.send_message(chat_id: message.chat.id, text: indroduceText, reply_markup: daySelect)
	when 'Today'
		funcToday
    	bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday}", reply_markup: daySelect)
    when 'Tomorrow'
    	funcTomorrow
    	bot.api.send_message(chat_id: message.chat.id, text: "#{funcTomorrow}", reply_markup: daySelect)
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "I hope you just lived those Mordor...")
    end
  end
end