require 'telegram/bot'
require './parserexcel.rb'
require './DefaultArrayComponent'
require './CheckAgendaDate.rb'

$keyBoardButtonsFirst = [
    Telegram::Bot::Types::KeyboardButton.new(text: 'Сегодня 1 группа'),
		Telegram::Bot::Types::KeyboardButton.new(text: 'Сегодня 2 группа')
]
$keyBoardButtonsSecond = [
		Telegram::Bot::Types::KeyboardButton.new(text: 'Завтра 1 группа'),
    Telegram::Bot::Types::KeyboardButton.new(text: 'Завтра 2 группа')
]
$daySelect = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [$keyBoardButtonsFirst, $keyBoardButtonsSecond], one_time_keyboard: false);

$groupSelect = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [$firstGroup.text, $secondGroup.text], one_time_keyboard: false);
$selectedDay = 1;

token = '1010148951:AAFCVQ9oeZZlPBEvW-_FIPYFicf24wKFg_U'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'        
    	bot.api.send_message(chat_id: message.chat.id, text: "Select day", reply_markup: $daySelect)
		when 'Сегодня 1 группа'
	    $selectedDay = 1;
			if ChangeOldFile();
	    	bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($firstGroup, $selectedDay)}", reply_markup: $daySelect, parse_mode: "Markdown")
			end
    when 'Сегодня 2 группа'
	    $selectedDay = 1;
			if ChangeOldFile();
				bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($secondGroup, $selectedDay)}", reply_markup: $daySelect, parse_mode: "Markdown")
			end
    when 'Завтра 1 группа'
    	$selectedDay = 2;
			if ChangeOldFile();
			bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($firstGroup, $selectedDay)}", reply_markup: $daySelect, parse_mode: "Markdown")
			end
    when 'Завтра 2 группа'
    	$selectedDay = 2;
			if ChangeOldFile()
    	bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($secondGroup, $selectedDay)}", reply_markup: $daySelect, parse_mode: "Markdown")
			end
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "I hope you just lived those Mordor...")
    end
  end
end