require 'percentage'
require 'descriptive_statistics'

def bayesian_estimate2(i1, i2)
  s = Time.now
  first_count = i1.count
  h = i1.map{|ii| [ii.indicator, true] }.to_h
  second_count = i2.count

  overlap = 0
  i2.each do |i|
    if h.has_key?(i.indicator)
      overlap += 1
    end
  end

  return nil unless overlap > 2

  population = (second_count - 1) * ( first_count ) / (overlap - 2)
  begin
    dev = ((second_count - 1) * (first_count - 1) * (first_count - overlap + 1) * (first_count - second_count + 1)) / ((overlap - 2) * (overlap - 2) * (overlap - 3))
  rescue ZeroDivisionError
    dev = 0
  end

  dev = Math.sqrt(dev.abs)

  [population, dev]
end

# https://stackoverflow.com/questions/11784843/calculate-95th-percentile-in-ruby
# https://github.com/wesyoung/descriptive_statistics

module Percentrank
  def rank(n)
    min, max = self.minmax.map(&:to_f)
    n = ((n - min) / (max - min))
    0 if n.nan?
    n
  end

  def prank(percentile)
    values = self.map(&:to_f)
    values_sorted = values.sort
    k = (percentile*(values_sorted.length-1)+1).floor - 1
    f = (percentile*(values_sorted.length-1)+1).modulo(1)

    values_sorted[k] + (f * (values_sorted[k+1] - values_sorted[k]))
  end


  def percent_change
    old, new = self[0].to_f, self[1].to_f
    if old == 0
      return 100
    end
    (( new - old) / old) * 100
  end

  def normalized(n=1000)
    (self[0] / self[1]) * n
  end
end

class Range
  include Percentrank
end

class Array
  include Percentrank

  def sum
    inject(0.0) { |result, el| result + el }
  end

  def mean
    sum / size
  end
end

