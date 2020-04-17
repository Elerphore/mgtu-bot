require 'telegram/bot'
require 'mysql2'

require './bot/src/DefaultVariables.rb'
require './bot/src/CheckAgendaDate.rb'
require './bot/src/CheckUserId.rb'
require './bot/src/ScheduleParsing.rb'

def funcToday(group, subgroup, day)
	@currNumber = Time.now.strftime("%u").to_i
	if day == 1
		@currNumber -= 1
	end
	return funcListParse(group, subgroup, $arraysWeek[@currNumber])
end

Telegram::Bot::Client.run(ENV["token"]) do |bot|
	@bot = bot
	@bot.listen do |message|
		@message = message
		
		def errorFunc
			@bot.api.send_message(chat_id: @message.chat.id, text: "Произошла ошибка соединения с порталом МГТУ.\nПовторите попытку позже, когда портал заработает: https://newlms.magtu.ru\nВ случае вопросов: @Elerphore", parse_mode: "Markdown")
		end
		
		def serveScheduleRequest(day, subgroup)
			@group = checkExistGroup(@bot, @message)
			if @group != nil
				if ChangeOldFile() && (@group.kind_of? String)
					@bot.api.send_message(chat_id: @message.chat.id, text: "#{funcToday(@group, subgroup, day)}", parse_mode: "Markdown", reply_markup: $daySelect)
				end
			end
		end
		
		case @message
		when Telegram::Bot::Types::CallbackQuery
			if $arrayGroups.include?(@message.data)
				@group = @message.data
				@bot.api.send_message(chat_id: @message.from.id, text: "Выбранная вами группа: #{@group}", reply_markup: $daySelect)
				$db.query("INSERT INTO heroku_378417f804fd0eb.`user_table_group` VALUES ('#{@message.from.id}', '#{@message.data}')")
			end
		when Telegram::Bot::Types::Message
			case @message.text
			when '/start'
				@group = checkExistGroup(@bot, @message)
			when 'Сегодня 1 группа'
				serveScheduleRequest(0, 0)
			when 'Сегодня 2 группа'
				serveScheduleRequest(0, 1)
			when 'Завтра 1 группа'
				serveScheduleRequest(1, 0)
			when 'Завтра 2 группа'
				serveScheduleRequest(1, 1)
			when 'Изменить группу'
				$db = Mysql2::Client.new(:host => "eu-cdbr-west-02.cleardb.net", :username => ENV["login"], :password => ENV["password"])
				$db.query("DELETE FROM heroku_378417f804fd0eb.`user_table_group` WHERE (`user_id` = '#{@message.chat.id}')")
				createArrayGroups()
				@bot.api.send_message(chat_id: @message.chat.id, text: 'Выбранная группа удалена.', reply_markup: $selecteGroup)
			end
		end
	end
end
