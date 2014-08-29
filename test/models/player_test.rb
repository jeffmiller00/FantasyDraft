require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'create a player from a string' do
    p = Player.new
    p.build_from_string 'Adrian Peterson, MIN'
    p.position = Position.first
    p.save
    assert true
  end

end
