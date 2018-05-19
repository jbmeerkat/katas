require File.join(__dir__, 'gilded_rose')

describe GildedRose do
  describe "#update_quality" do
    let(:items) { [Item.new("foo", 0, 0)] }

    before { GildedRose.new(items).update_quality }

    it "does not change the name" do
      expect(items[0].name).to eq "fixme"
    end
  end
end
