$:.unshift File.dirname(__FILE__) + '/../lib'
require 'shake_n_bake'

ShakeNBake do

  INTERVAL = 2

  shake do
    puts 'Enter a number'
    STDIN.gets # return to bake
  end

  bake do |result|
    puts result.to_i + 10 # add 10 to result
    puts 'Cool, lets play again!'
  end
end