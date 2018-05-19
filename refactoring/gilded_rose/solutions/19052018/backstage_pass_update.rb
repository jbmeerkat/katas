class BackstagePassUpdate
  def self.call(item)
    decrease_sell_in(item)
    change_quality(item)
  end

  def self.change_quality(item)
    return unless (0..50).include?(item.quality)

    new_quality = case item.sell_in
    when 10..50 then 1
    when 5..10 then 2
    when 0..5 then 3
    when -1 then -item.quality
    end

    item.quality += new_quality
  end

  def self.decrease_sell_in(item)
    item.sell_in -= 1
  end
end
