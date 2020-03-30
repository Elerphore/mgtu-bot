require 'telegram/bot'

	@xlsx = Roo::Spreadsheet.open("./changeAgenda.xlsx");
	$arrayGroups = @xlsx.row(2);
	@arrayGroupsComp = $arrayGroups.compact;
	$keyboards = @arrayGroupsComp.map do |arr|
	Telegram::Bot::Types::InlineKeyboardButton.new(text: arr, callback_data: arr)
	end
	@selecteGroup =  Telegram::Bot::Types::InlineKeyboardMarkup.new(
	                                    inline_keyboard: $keyboards);


def checkExistGroup(bot, message)
	@results = $db.query("SELECT * FROM heroku_378417f804fd0eb.`user_table_group`
												WHERE user_id = #{message.chat.id}");
	$userHash = @results.each[0];
	if $userHash != nil 
		bot.api.send_message(chat_id: message.chat.id, text: "Бот запомнил вашу группу: #{$userHash["group_name"]}, не нужно её выбирать",
		reply_markup: $daySelect);
	else
		bot.api.send_message(chat_id: message.chat.id, text: 'Бот не знает вашей группы, выберите её из списка.', reply_markup: @selecteGroup)
	end
end
