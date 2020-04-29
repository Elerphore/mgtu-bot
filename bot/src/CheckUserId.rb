def createArrayGroups
	@id = 573029
	$arrayGroups = []
	while @id != 573034
		begin
			$content = Nokogiri::HTML(open("https://newlms.magtu.ru/mod/folder/view.php?id=#{@id}"))
		rescue OpenURI::HTTPError => error
			if error
				errorFunc()
				return nil
			end
		end
		
		@lengthArrayCSS = $content.css('.fp-filename').children.length
		
		(0...@lengthArrayCSS).each do |i|
			@contentCSS = $content.css('.fp-filename').children[i].text
			if /\W{1,4}\-\d{2}\-\d{1}.xlsx$/.match?(@contentCSS)
				$arrayGroups.push(@contentCSS.delete('.xlsx'))
			elsif /\W{1,4}\-\d{2}\-\d{1} изм. с \d{2}.\d{2}.\d{2}.xlsx$/.match?(@contentCSS)
				@str = @contentCSS.split[0]
				$arrayGroups.push(@str)
			end
		end
			@id += 1
	end
	return true
end

def getGroupsInlineKeyboard
	inlineKeyboard = $arrayGroups.map do |array|
		Telegram::Bot::Types::InlineKeyboardButton.new(text: array, callback_data: array)
	end
	return Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: inlineKeyboard)
end

def queryUserGroup(bot, message)
	$db = Mysql2::Client.new(host: "eu-cdbr-west-02.cleardb.net", username: ENV["login"], password: ENV["password"])
	group = $db.query("SELECT group_name FROM heroku_378417f804fd0eb.`user_table_group` WHERE user_id = #{message.chat.id}").to_a&.[](0)
	return group
end

def getUserGroup(bot, message)
	group = queryUserGroup(bot, message)
	if group
		return group
	elsif createArrayGroups()
		bot.api.send_message(chat_id: message.chat.id, text: 'Бот не знает вашей группы, выберите её из списка.', reply_markup: getGroupsInlineKeyboard)
		return nil
	end
end
