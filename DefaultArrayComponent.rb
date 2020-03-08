$weekCount = Time.now.strftime("%U").to_i;
$weekNumber = Time.now.strftime("%u").to_i;

class Group
  def initialize(id, text)
    @id = id;
    @text = text;
  end

  attr_reader :id, :text
end

$firstGroup = Group.new(1, "First Group");
$secondGroup = Group.new(2, "Second Group");