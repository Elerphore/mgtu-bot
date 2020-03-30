$userId = Hash.new;

$userId[321321] = 'Исп-19-4';
$userId[6666666] = 'Механики ебаные';

p $userId;
p $userId.has_key?(321321);
p $userId.has_key?(321);