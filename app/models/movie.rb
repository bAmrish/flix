class Movie < ApplicationRecord

  def flop?
    total_gross <= 10_00_000_00
  end
end
