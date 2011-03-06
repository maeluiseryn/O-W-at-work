

p="c666p55odp".partition(/[0-9]{2,5}/)
client=p[1]
p2=p[2].partition(/[0-9]{1,5}/)
project=p2[1]
puts "#{client} #{project}"
end  