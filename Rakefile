require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('simplesem', '0.1.1') do |p|
  p.description         = "SIMPLESEM Interpreter"
  p.url                 = "http://github.com/robolson/simplesem"
  p.author              = "Rob Olson"
  p.email               = "rko618@gmail.com"
  p.development_dependencies = ['treetop']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }