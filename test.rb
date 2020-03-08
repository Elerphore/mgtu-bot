class Group
  @id;
  @text;
  def initialize(id, text)
    @id = id;
    @text = text;
  end

  attr_reader :id, :text

end

firstGroup = Group.new(1, "First Group");

puts(firstGroup.text);