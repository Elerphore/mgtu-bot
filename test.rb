require 'nokogiri'
require 'open-uri'
require 'openssl'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE




# @arrayGroupses = [];
# @id = 573029;

# while @id != 573034
# 	$content = Nokogiri::HTML(open("https://newlms.magtu.ru/mod/folder/view.php?id=#{@id}"));
# 	@lenghtArrayCSS = $content.css('.fp-filename').children.length;

# 		(0...@lenghtArrayCSS).each do |i| 
# 		@ContentCss = $content.css('.fp-filename').children[i].text
# 			if /\W{1,4}\-\d{2}\-\d{1}.xlsx$/.match?(@ContentCss)
# 				@arrayGroupses.push(@ContentCss.delete('.xlsx'));
# 			end
# 	end
# 		@id = @id + 1;
# end

$ewew = "Мэ-19-1"
$str = "Мэ-19-1 изм. с 09.03.20.xlsx";

if /\W{1,4}\-\d{2}\-\d{1} изм. с \d{2}.\d{2}.\d{2}.xlsx$/.match?($str)
	p $str.split[0];

end