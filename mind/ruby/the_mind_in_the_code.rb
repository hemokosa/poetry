# Pre-conversion program
p = "m = rand; puts 'The mind is an internal state that is not accessible from the outside.'"

# Convert the entire program before conversion into lowercase alphabet
print "public; "
print "def each; "
print "clear; "
p.bytes.reverse_each do |c|
  # Convert one letter of the pre-conversion program into lowercase alphabet
  print "concat begin; "
  print "dup ensure concat begin; "
  print "clear; "
  c.to_s(2).scan(/(10*)($)?/).map do |v, last|
    # A line of concat concat ... size is generated for each bit of 1
    print "#{ "concat " * (last ? v.size : v.size + 1) }size; "
  end
  print "size; "
  print "ensure; "
  print "clear; "
  print "end; "
  print "end; "
end
print "eval self; "
print "end; "
print "for each in inspect do end; "
