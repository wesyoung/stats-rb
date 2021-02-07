require 'percentage'
require 'descriptive_statistics'


def bayesian_estimate(a1, a2)
  count1 = a1.count
  count2 = a2.count

  overlap = 0
  a2.each do |e|
    overlap += 1 if a1.include? e
  end

  return nil unless overlap > 2

  dev = 0
  population = (count2 - 1) * ( count1 ) / (overlap - 2)

  divisor = (overlap - 2) * (overlap - 2) * (overlap - 3)
  if divisor > 0
    dev = (
      (count2 - 1) *
      (count1 - 1) *
      (count1 - overlap + 1) *
      (count1 - count2 + 1)
    ) / divisor

    dev = Math.sqrt(dev.abs)
  end

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
    inject(0) { |result, el| result + el }
  end

  def mean
    return 0 if size == 0
    sum / size
  end

  def sum2
    inject(0) { |result, el| result + el }
  end

  def mean2
    return 0 if size == 0
    sum / size
  end
end

