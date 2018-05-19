require_relative 'item'
require_relative 'item_update'
require_relative 'aged_brie_update'
require_relative 'backstage_pass_update'
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        AgedBrieUpdate.call(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        BackstagePassUpdate.call(item)
      when 'Sulfuras, Hand of Ragnaros'
      else
        ItemUpdate.call(item)
      end
    end
  end
end
