def createArrayGroups
		@id = 573029
	$arrayGroupses = []
	while @id != 573034
		begin
		$content = Nokogiri::HTML(open("https://newlms.magtu.ru/mod/folder/view.php?id=#{@id}"))
		rescue OpenURI::HTTPError => error
			if error
				errorFunc()
				return nil
			end
		end

		@lenghtArrayCSS = $content.css('.fp-filename').children.length

		(0...@lenghtArrayCSS).each do |i|
			@ContentCss = $content.css('.fp-filename').children[i].text
			if /\W{1,4}\-\d{2}\-\d{1}.xlsx$/.match?(@ContentCss)
				$arrayGroupses.push(@ContentCss.delete('.xlsx'))
			elsif /\W{1,4}\-\d{2}\-\d{1} изм. с \d{2}.\d{2}.\d{2}.xlsx$/.match?(@ContentCss)
				@str = @ContentCss.split[0]
				$arrayGroupses.push(@str)
			end
		end
			@id = @id + 1
	end

	@keyboards = $arrayGroupses.map do |arr|
		Telegram::Bot::Types::InlineKeyboardButton.new(text: arr, callback_data: arr)
	end
	$selecteGroup =  Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @keyboards)
end

def checkExistGroup(bot, message)
	$db = Mysql2::Client.new(:host => "eu-cdbr-west-02.cleardb.net", :username => ENV["login"], :password => ENV["password"])
	@userHash = Hash.new
	@results = $db.query("SELECT * FROM heroku_378417f804fd0eb.`user_table_group` WHERE user_id = #{message.chat.id}")
	@userHash = @results.each[0]
	if @userHash != nil
		return @userHash["group_name"]
	else
		createArrayGroups()
		if $selecteGroup != nil
					bot.api.send_message(chat_id: message.chat.id, text: 'Бот не знает вашей группы, выберите её из списка.', reply_markup: $selecteGroup)
		end
	end
end
