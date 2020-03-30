require 'telegram/bot'

					@xlsx = Roo::Spreadsheet.open("./changeAgenda.xlsx");
					$arrayGroups = @xlsx.row(2);
					@arrayGroupsComp = $arrayGroups.compact;

					$keyboards = @arrayGroupsComp.map do |arr|
						Telegram::Bot::Types::InlineKeyboardButton.new(text: arr, callback_data: arr)
					end
					@selecteGroup =  Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: $keyboards);


def checkExistGroup(bot, message)
				if !$cookies.has_key?(message.chat.id)
					bot.api.send_message(chat_id: message.chat.id, text: 'Бот не знает вашей группы, выберите её из списка.', reply_markup: @selecteGroup)
				elsif $cookies.has_key?(message.chat.id)
					bot.api.send_message(chat_id: message.chat.id, text: "Бот запомнил вашу группу: #{$cookies[message.chat.id]}, не нужно её выбирать",
					 reply_markup: $daySelect)
				end
			end
