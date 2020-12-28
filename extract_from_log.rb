f = File.read(ARGV[0])

f.scan(%r{##(.*?)<---}mi).each do |(m)|
  puts "##" + m
  puts 
  puts 
end

