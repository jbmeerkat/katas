require File.join(__dir__, '../gilded_rose')

describe GildedRose do
  shared_examples 'item' do
    specify { expect(item.quality).to be_between(0, 50)  }
  end

  describe "#update_quality" do
    let(:item) { Item.new("foo", 0, 0) }

    before { GildedRose.new([item]).update_quality }

    it "does not change the name" do
      expect(item.name).to eq "foo"
    end

    context 'with `Aged Brie`' do
      let(:item) { Item.new('Aged Brie', 1, 42) }

      it do
        expect(item.quality).to eq 43
      end
    end

    describe 'sell_in' do
      subject(:update) { GildedRose.new([item]).update_quality }

      it { expect { update }.to change { item.sell_in }.by(-1) }

      context 'with `Sulfuras, Hand of Ragnaros`' do
        let(:item) { Item.new('Sulfuras, Hand of Ragnaros', 0, 0) }

        it { expect { update }.not_to change { item.sell_in } }
      end
    end

    it_behaves_like 'item'
  end
end
