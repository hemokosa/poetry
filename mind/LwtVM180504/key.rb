loop do
   print '*'
   sleep(1)

   system("stty raw -echo")
   char = STDIN.read_nonblock(1) rescue nil
   system("stty -raw echo")

   puts("\n キー入力されました:#{char}") if char
   break if /q/i =~ char
 end
