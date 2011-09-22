# Shake-N-Bake

A very simple dsl that allows you to neatly watch for something
for a given Interval and then once the result is received and
valid the publish/write the result.

AKA.

# `Shake` ~ N ~ `Bake`

## Example 1 : Consuming a Job from a Cloudq

``` ruby
require 'shake_n_bake'

ShakeNBake do

  INTERVAL = 2 # seconds

  setup do
    @cloudq = Cloudq::Consumer.new 'incoming_fax'
  end

  shake do
    # watch a queue
    @cloudq.get_job
  end

  bake do |job|
    Fax.new(job[:args]).deliver
    @cloudq.complete_job job.id
  end
end

```

## Example 2 : Watching a local database and publishing a job

``` ruby
require 'sequel'
require 'chronic'
require 'cloudq'
require 'shake_n_bake'

ShakeNBake do
  
  INTERVAL = 10 # seconds

  setup do
    # my db connection
  end

  shake do
    # watch for change form a db
    DB['select is_awesome from foo where chg_date < ?', Chronic.parse('10 seconds ago')].get
  end

  bake do |result|
    # publish it to cloudq
    Cloudq::Publish.new('awesome').job 'Person', :awesome => result  
  end

end

```

_If your not first your last_

`Shake` ~ N ~ `Bake`

See LICENSE.
