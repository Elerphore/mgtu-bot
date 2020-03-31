require 'telegram/bot';
require './parserexcel.rb';
require './DefaultArrayComponent';
require './CheckAgendaDate.rb';
require './IdDataBaseCheck.rb';
require 'mysql2';
$db = Mysql2::Client.new(:host => "eu-cdbr-west-02.cleardb.net", :username => "b4e1fdda6d85bd",
		                     :password => "df82ac8e");
$keyBoardButtonsFirst = [
    Telegram::Bot::Types::KeyboardButton.new(text: 'Сегодня 1 группа'),
		Telegram::Bot::Types::KeyboardButton.new(text: 'Сегодня 2 группа')
]
$keyBoardButtonsSecond = [
		Telegram::Bot::Types::KeyboardButton.new(text: 'Завтра 1 группа'),
    Telegram::Bot::Types::KeyboardButton.new(text: 'Завтра 2 группа')
]
$daySelect = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [$keyBoardButtonsFirst, $keyBoardButtonsSecond], one_time_keyboard: false);

token = '1010148951:AAFCVQ9oeZZlPBEvW-_FIPYFicf24wKFg_U'
Telegram::Bot::Client.run(token) do |bot|

  bot.listen do |message|
  	case message
  		  when Telegram::Bot::Types::CallbackQuery
					if @arrayGroupsComp.include?(message.data)
						@group = message.data;
						bot.api.send_message(chat_id: message.from.id, text: "Выбранная вами группа: #{@group}
						 бот запомнит её. Если вы хотите её удалить пропишите /removegroup",
						 reply_markup: $daySelect);
						$db.query("INSERT INTO heroku_378417f804fd0eb.`user_table_group` 
						          VALUES  ('#{message.from.id}', '#{message.data}')");
	    		end
    	when Telegram::Bot::Types::Message
				case message.text
				when '/start'
    			@group = checkExistGroup(bot, message)
    		when 'Сегодня 1 группа'
    			@group = checkExistGroup(bot, message)
   				if ChangeOldFile();
	  	  		bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($firstGroup, 1, @group)}", reply_markup: $daySelect, parse_mode: "Markdown")
					end
				when 'Сегодня 2 группа'
    			@group = checkExistGroup(bot, message)
					if ChangeOldFile();
						bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($secondGroup, 1, @group)}", reply_markup: $daySelect, parse_mode: "Markdown")
					end
	    when 'Завтра 1 группа'
    			@group = checkExistGroup(bot, message)
					if ChangeOldFile();
						bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($firstGroup, 2, @group)}", reply_markup: $daySelect, parse_mode: "Markdown")
					end
	    when 'Завтра 2 группа'
    			@group = checkExistGroup(bot, message)
					if ChangeOldFile()
	    			bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($secondGroup, 2, @group)}", reply_markup: $daySelect, parse_mode: "Markdown")
					end
				end

  	end
  end
end