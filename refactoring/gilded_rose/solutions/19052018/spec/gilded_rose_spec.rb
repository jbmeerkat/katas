require 'pry'
require File.join(__dir__, '../gilded_rose')

describe GildedRose do
  shared_examples 'item' do
    specify { expect(item.quality).to be_between(0, 50)  }
  end

  describe "#update_quality" do
    let(:item) { Item.new("foo", 0, 0) }

    subject(:update) { GildedRose.new([item]).update_quality }

    it "does not change the name" do
      update
      expect(item.name).to eq "foo"
    end

    context 'with `Aged Brie`' do
      let(:item) { Item.new('Aged Brie', 1, 42) }

      it do
        update
        expect(item.quality).to eq 43
      end

      context 'sell in date is due' do
        let(:item) { Item.new('Aged Brie', 0, 42) }

        xit do
          update
          expect(item.quality).to eq 43
        end
      end
    end

    describe 'sell_in' do
      it { expect { update }.to change { item.sell_in }.by(-1) }
    end

    context 'with `Sulfuras, Hand of Ragnaros`' do
      let(:item) { Item.new('Sulfuras, Hand of Ragnaros', 0, 80) }

      it { expect { update }.not_to change { item.sell_in } }
      it { expect { update }.not_to change { item.quality } }
    end

    context 'with `Backstage passes to a TAFKAL80ETC concert`' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

      shared_examples 'backstage pass' do |options|
        let(:item) { Item.new(name, options[:sell_in], 10) }

        context "when #{options[:sell_in]} days till the concert" do
          specify do
            expect { update }.to change { item.quality }.by(options[:quality_change])
          end
        end
      end

      it_behaves_like 'backstage pass', sell_in: 12, quality_change: 1
      it_behaves_like 'backstage pass', sell_in: 10, quality_change: 2
      it_behaves_like 'backstage pass', sell_in: 5, quality_change: 3

      context 'when concert has passed' do
        let(:item) { Item.new(name, 0, 10) }

        it { expect { update }.to change { item.quality }.from(10).to(0) }
      end
    end

    context 'when sell in is due' do
      let(:item) { Item.new('foo', 0, 10) }

      specify { expect { update }.to change(item, :quality).by(-2) }
    end

    it_behaves_like 'item'
  end
end
