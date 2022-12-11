module NumberPrintingHelper
  def with_sign(num)
    if num == 0
      return "0"
    elsif num > 0
      return "+#{num}"
    else
      return "#{num}"
    end
  end
end
