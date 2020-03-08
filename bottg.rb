require 'telegram/bot'
require './parserexcel.rb'
require './DefaultArrayComponent'

$selectedDay = 0;
token = '1010148951:AAFCVQ9oeZZlPBEvW-_FIPYFicf24wKFg_U'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
        

    	indroduceText = 'select your day'
    	$daySelect = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [%w(Today), %w(Tomorrow)], one_time_keyboard: false);
		$groupSelect = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [$firstGroup.text, $secondGroup.text], one_time_keyboard: false);

    	bot.api.send_message(chat_id: message.chat.id, text: indroduceText, reply_markup: $daySelect)
	when 'Today'
	    $selectedDay = 1;
    	bot.api.send_message(chat_id: message.chat.id, text: "Select Group", reply_markup: $groupSelect)
    when 'First Group'
    	bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($firstGroup, $selectedDay)}", reply_markup: $daySelect)
    when 'Second Group'
    	bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($secondGroup, $selectedDay)}", reply_markup: $daySelect)
    when 'Tomorrow'
    	$selectedDay = 2;
    	bot.api.send_message(chat_id: message.chat.id, text: "Select Group", reply_markup: $groupSelect)
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "I hope you just lived those Mordor...")
    end
  end
end