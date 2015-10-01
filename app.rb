#!/usr/bin/env ruby
require "rubygems"
require "sinatra"

get "/" do
  send_file 'public/index.html'
end

