require "shake_n_bake/version"
require 'singleton'

module ShakeNBake; end

require File.dirname(__FILE__) + '/shake_n_bake/dsl'

def ShakeNBake(&block)
  snb = ShakeNBake::DSL.instance
  snb.instance_eval(&block)
  snb.run
end
