#!/usr/bin/env ruby
require File.expand_path(File.dirname((__FILE__)) + '/twitter_api.rb')
require File.expand_path(File.dirname((__FILE__)) + '/key.rb')
require 'json'
require 'digest/md5'
require 'readline'

status = ARGV.join ' '

if status == ""
  puts "Usage: tweet [something to tweet]"
  exit false
end

puts ""
puts "ツィート本文:「\e[1m\e[37m#{status}\e[0m」"
m = Readline.readline " > "
confirm_length = 6
check = Digest::MD5.hexdigest(status + Time.now.to_s + Random.new(1234).to_s)[0..confirm_length]

puts "確認のために【\e[33m\e[1m#{check}\e[0m】と入力してください"

if m == ""
  puts "キャンセルしました"
  exit false
elsif m != check
  puts "\e[35m[ERROR] 確認失敗\e[0m"
  exit false
end
res = tweet $key, status
jd = JSON.parse res

if err = jd["error"] || (jd["errors"] && jd["errors"][0])
  puts "\e[35m[ERROR] #{err["message"]} (#{err["code"]})\e[0m"
  exit false
end
if jd["id_str"]
  puts "ツィート成功 ( http://twitter.com/statuses/#{jd["id_str"]} )"
else
  p jd
  exit false
end
