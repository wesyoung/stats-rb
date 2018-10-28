require 'minitest/autorun'
require 'stats'
require 'pp'

class TestStats < Minitest::Test
  def setup
  end

  def test_stats
    assert [1,2].sum() == 3

    assert [1,2,3,4].rank(5).round(2) == 1.33

    assert [50, 100].percent_change == 100

    assert [50, 75].percent_change == 50.0

    assert [1, 1, 1, 1, 1, 1, 1].percentile_rank(2) == 100
  end

end