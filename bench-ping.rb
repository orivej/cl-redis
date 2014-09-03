require 'rubygems'
require 'redis'

def bench(descr)
  start = Time.now
  yield
  puts "#{descr} #{Time.now-start} seconds"
end

def without_pipelining
  r = Redis.new
  100000.times {
    r.ping
  }
end

def with_pipelining
  r = Redis.new
  r.pipelined {
    100000.times {
      r.ping
    }
  }
end

bench("without pipelining") {
  without_pipelining
}
bench("with pipelining") {
  with_pipelining
}
