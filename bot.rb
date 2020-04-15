require 'telegram/bot';
require './bot/src/DayDiverting.rb';
require './bot/src/DefaultVariables.rb';
require './bot/src/CheckAgendaDate.rb';
require './bot/src/CheckUserId.rb';
require 'mysql2';

p ENV[:token];

Telegram::Bot::Client.run(@token) do |bot|
	@bot = bot;
  bot.listen do |message|
  	@message = message;
  		def errorFunc
  		@bot.api.send_message(chat_id: @message.chat.id, text: "Произошла ошибка, повторите попытку позже.
В случае вопросов: @Elerphore", parse_mode: "Markdown");
  		end
  	case message
  		  when Telegram::Bot::Types::CallbackQuery
					if $arrayGroupses.include?(message.data)
						@group = message.data;
						bot.api.send_message(chat_id: message.from.id, text: "Выбранная вами группа: #{@group}",
						 reply_markup: $daySelect);
						$db.query("INSERT INTO heroku_378417f804fd0eb.`user_table_group` 
						          VALUES  ('#{message.from.id}', '#{message.data}')");
	    		end
    	when Telegram::Bot::Types::Message
				case message.text
				when '/start'
    			@group = checkExistGroup(bot, message)
    		when 'Сегодня 1 группа'
    			@group = checkExistGroup(bot, message);
   				if ChangeOldFile();
   					if @group != nil && (@group.kind_of? String)
		  	  		bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($firstGroup, 1, @group)}", parse_mode: "Markdown",
		  	  		                     reply_markup: $daySelect)
   					end
					end
				when 'Сегодня 2 группа'
    			@group = checkExistGroup(bot, message)
					if ChangeOldFile();
						if @group != nil && (@group.kind_of? String)
							bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($secondGroup, 1, @group)}", parse_mode: "Markdown",
							                     reply_markup: $daySelect)
						end
					end
	    when 'Завтра 1 группа'
    			@group = checkExistGroup(bot, message)
					if ChangeOldFile();
						if @group != nil && (@group.kind_of? String)
							bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($firstGroup, 2, @group)}", parse_mode: "Markdown",
							                     reply_markup: $daySelect)
						end
					end
	    when 'Завтра 2 группа'
    			@group = checkExistGroup(bot, message)
					if ChangeOldFile()
						if @group != nil && (@group.kind_of? String)
							bot.api.send_message(chat_id: message.chat.id, text: "#{funcToday($secondGroup, 2, @group)}", parse_mode: "Markdown",
							                     reply_markup: $daySelect)
						end
					end
			when 'Изменить группу'
					$db = Mysql2::Client.new(:host => "eu-cdbr-west-02.cleardb.net", :username => @username,
		                     :password => @password);
						$db.query("DELETE FROM heroku_378417f804fd0eb.`user_table_group` 
						          WHERE (`user_id` = '#{message.chat.id}')");
					createArrayGroups()
					bot.api.send_message(chat_id: message.chat.id, text: 'Выбранная группа удалена.', reply_markup: $selecteGroup);
				end
  	end
  end
end