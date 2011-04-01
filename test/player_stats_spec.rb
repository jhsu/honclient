require "test_helper"

describe HoN::PlayerStats do
  before(:all) do
    @player = HoN::PlayerStats.new('jhsu')
  end

  it "should be able to fetch a player" do
    @player.stats.keys.length.should >= 1
  end

  it "should have a decent psr" do
    @player.psr.to_i.should >= 0
  end
end
