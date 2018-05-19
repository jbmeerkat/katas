class ItemUpdate
  def self.call(item)
    decrease_sell_in(item)
    decrease_quality(item)
  end

  def self.decrease_quality(item)
    return unless (0..50).include?(item.quality)

    new_quality = item.sell_in < 0 ? 2 : 1
    item.quality -= new_quality
  end

  def self.decrease_sell_in(item)
    item.sell_in -= 1
  end
end
