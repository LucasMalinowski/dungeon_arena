module CharactersHelper
  def modifier_for(character, attr)
    ((character.send(attr) - 10) / 2).floor
  end
end
