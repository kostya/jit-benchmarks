f = File.read(ARGV[0])

h = {}
f.scan(%r{##(.*?)\n(.*?)<---}mi).each do |(title, body)|
  h[title] = body
end

h.sort_by { |(k, v)| k }.each do |title, body|
  puts "##" + title
  puts body
  puts
  puts
end
