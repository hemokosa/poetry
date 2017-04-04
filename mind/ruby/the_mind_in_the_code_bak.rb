# Pre-conversion program
p = "m = rand; p m; puts 'The mind is an internal state that is not accessible from the outside.'"

# Convert the entire program before conversion into lowercase alphabet
puts "public"
puts "def each"
puts "  clear"
p.bytes.reverse_each do |c|
  # Convert one letter of the pre-conversion program into lowercase alphabet
  puts "  concat begin"
  puts "    dup ensure concat begin"
  puts "      clear"
  c.to_s(2).scan(/(10*)($)?/).map do |v, last|
    # A line of concat concat ... size is generated for each bit of 1
    puts "      #{ "concat " * (last ? v.size : v.size + 1) }size"
  end
  puts "      size"
  puts "    ensure"
  puts "      clear"
  puts "    end"
  puts "  end"
end
puts "  eval self"
puts "end"
puts "for each in inspect do end"
