require 'net/http'
require 'uri'
require 'json'
require 'date'
require 'nokogiri'
require 'open-uri'

class MAIN
  def initialize(src)
    @src = src
    @accum = 0
    @mind = 50
    @base = 25
    @min = 10
    @max = 20
    @code = ""
    @count = 0
    @countold = 0
    @th = []
    @tn = 0
    @inc = 1
    @com = "HhQqLlSsIiCcDdTtGgPp9FfRrKk+-,.?<#,;!Ww _\n"
    @step = 0
    srand(Time.now.to_i)
    cmd = "say -v " + ["Alex", "Junior", "Princess", "Samantha", "Vicki", "Victoria"].sample
    cin = "[[volm 0.2]]" + src
    IO.popen(cmd, 'r+') do |pipe|
      pipe.write(cin)
      pipe.close_write
    end
  end

  def run
    loop {
      system("stty raw -echo")
      k = STDIN.read_nonblock(1) rescue nil
      system("stty -raw echo")
      if k == "."
        puts
        break
      end

      c = @src[@count]
      case c
      when /H|h/
        hello
      when /Q|q/
        speak_source
      when /L|l/
        count_source
      when /S|s/
        sort_source
      when /I|i/
        introspection
      when /C|c/
        consciousness
      when /D|d/
        infrathins
      when /T|t/
        truism
      when /G|g/
        gbb
      when /P|p/
        pangram
      when "9"
        bottles_of_beer
      when /F|f/
        fizz_buzz
      when /R|r/
        rhyme
      when /K|k/
        kardashian
      when "1"
        start_10
      when "0"
        kill_10
      when "+"
        increment
      when "-"
        decrement
      when "."
        top
      when "?"
        jump
      when "<"
        back
      when "^"
        rev
      when "#"
        go
      when ";"
        append
      when ","
        overwrite
      when "!"
        intervent
      when /W|w/
        weather
      when " "
        puts
      when "_"
        sleep(1)
      end
      @code = c
      @countold = @count
      @count += @inc
      if @count >= @src.length || @count < 0 then
        break
      end
      File.open(ARGF.filename){|f|
        @src = f.read
        if @count >= @src.length then
          @count = 0
        end
      }
      @step += 1
      emotion
      @count.times{ print "." }
      puts c
    }
  end

  private

  def speak(message)
    fname = 'name.txt'
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    n = rand(line_count)
    File.open(fname).each_with_index { |line, index|
      if index == n then
        rate = 120 + rand(@mind)
        rate = 50 if rate < 50
        rate = 500 if rate > 500
        cmd = "say -r " + rate.to_s + " -v " + line.chop
        pitch = rand(@mind)/2
        if rand(2) == 0
          cpre = "[[volm 0.2]][[pbas + " + pitch.to_s + "]] "
        else
          cpre = "[[volm 0.2]][[pbas - " + pitch.to_s + "]] "
        end
        cin = cpre + message.to_s
        IO.popen(cmd, 'r+') do |pipe|
          pipe.write(cin)
          pipe.close_write
        end
      end
    }
  end

  def hello
    puts "Hello, world!"
    speak("Hello, world!")
  end

  def speak_source
    speak(@src)
  end

  def count_source
    File.open(ARGF.filename) {|f|
      l_num = w_num = c_num = 0
      while line = f.gets
        line.chomp!
        l_num += 1

        words = line.split(/\s+/).reject{|w| w.empty?}
        w_num += words.size
        c_num += line.size
      end
      print l_num, " ", w_num, " ", c_num
      speak(l_num)
      speak(w_num)
      speak(c_num)
      puts
    }
  end

  def sort_source
    dic = Hash.new(0)
    File.open(ARGF.filename) {|f|
      while line = f.gets
        line.downcase!
        while line.sub!(/[a-z]+/, "")
          word = $&
          dic[word] += 1
        end
      end
      dic.sort.each {|key, value|
        print key, " ", value, " "
        speak(key)
        speak(value)
      }
      puts
    }
  end

  def introspection
    fname = File.basename(__FILE__)
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    n = rand(line_count)
    File.open(fname).each_with_index { |line, index|
      puts line if index == n
      speak(line) if index == n
    }
  end

  def infrathins
    fname = 'infrathins.txt'
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    n = rand(line_count)
    File.open(fname).each_with_index { |line, index|
      puts line if index == n
      speak(line) if index == n
    }
  end

  def consciousness
    fname = 'consciousness.txt'
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    n = rand(line_count)
    File.open(fname).each_with_index { |line, index|
      puts line if index == n
      speak(line) if index == n
    }
  end

  def truism
    fname = 'truisms.txt'
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    n = rand(line_count)
    File.open(fname).each_with_index { |line, index|
      puts line if index == n
      speak(line) if index == n
    }
  end

  def gbb
    fname = 'gbb.txt'
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    (@accum + 3).times{
      n = rand(line_count)
      File.open(fname).each_with_index { |line, index|
        print line.chop if index == n
        if index == n then
          if rand(2) == 1
            speak("[[emph +]] " + line.chop)
          else
            speak("[[emph -]] " + line.chop)
          end
        end
      }
      print " "
    }
    puts
  end

  def pangram
    fname = 'pan.txt'
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    n = rand(line_count)
    File.open(fname).each_with_index { |line, index|
      puts line if index == n
      speak(line) if index == n
    }
  end

  def bottles_of_beer
    @accum.downto(0) do |k|
      case k
      when 0
        before = "no more bottles"
        after = "99 bottles"
      when 1
        before = "1 bottle"
        after = "no more bottles"
      when 2
        before = "2 bottles"
        after = "1 bottle"
      else
        before = "#{k} bottles"
        after = "#{k-1} bottles"
      end
      sleep(1)

      if k == 0
        action = "Go to the store and buy some more"
      else
        action = "Take one down and pass it around"
      end

      puts "#{before.capitalize} of beer on the wall, #{before} of beer."
      speak("#{before.capitalize} of beer on the wall, #{before} of beer.")
      puts "#{action}, #{after} of beer on the wall."
      speak("#{action}, #{after} of beer on the wall.")
      puts "" unless k == 0
    end
  end


  def fizz_buzz
    1.upto(@accum) do |i|
      if i % 5 == 0 and i % 3 == 0
        puts "FizzBuzz"
        speak("FizzBuzz")
      elsif i % 5 == 0
        puts "Buzz"
        speak("Buzz")
      elsif i % 3 == 0
        puts "Fizz"
        speak("Fizz")
      else
        puts i
        speak(i)
      end
      sleep(1)
    end
  end

  def rhyme
    fname = 'rhyme.txt'
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    4.times{
      n = rand(line_count)
      File.open(fname).each_with_index { |line, index|
        puts line if index == n
        speak(line) if index == n
      }
    }
  end

  def kardashian
    term = "Kim+Kardashian+Marriage"
    url = "http://www.google.com/search?num=100&hl=en&q=" + term
    page = open url
    doc = Nokogiri::HTML page

    n = rand(72)
    doc.search('h3 a').each_with_index do |phrase, index|
      puts phrase.inner_text if index == n
      speak(phrase.inner_text) if index == n
    end
  end

  def start_10
    @tn += 1
    n = rand(1..9)
    @th[@tn] = Thread.start {
      loop do
        case n
        when 1
          print [40, 41][rand(0..1)].chr
        when 2
          print [60, 62][rand(0..1)].chr
        when 3
          print [91, 93][rand(0..1)].chr
        when 4
          print [95, 124][rand(0..1)].chr
        when 5
          print [123, 125][rand(0..1)].chr
        else
          print [47, 92][rand(0..1)].chr
        end
        sleep(10.0*@base/@mind)
      end
    }
  end

  def kill_10
    begin
      Thread.kill(@th[@tn])
      @tn -= 1
      puts
    rescue
      puts "Error of Thread Comes As No Surprise.\n"
    end
  end

  def increment
    @accum += 1
    @mind += rand(2)
  end

  def decrement
    @accum -= 1
    if @accum < 0
      @accum = 0
    end
    @mind -= rand(2)
  end

  def top
    @count = -1
  end

  def jump
    @count = rand(@src.length) - 1
  end

  def back
    @count = rand(@count) - 1
  end

  def rev
    @inc = -1 * @inc
  end

  def go
    g = @accum
    if g > @src.length then
      g = @src.length
    end
    @count = g
  end

  def append
    File.open(ARGF.filename, 'a') {|f|
      f.write(@com.slice(rand(@com.length)))
    }
  end

  def overwrite
    File.open(ARGF.filename, 'r+') {|f|
      f.sync = true
      f.seek(rand(@src.length), IO::SEEK_SET)
      f.write(@com.slice(rand(@com.length)))
    }
  end

  def intervent
    overwrite
    top
  end

  def weather
    begin
      uri = URI.parse('http://weather.livedoor.com/forecast/webservice/json/v1?city=130010')
      json = Net::HTTP.get(uri)
      result = JSON.parse(json)
      #puts result['forecasts']
    rescue
      puts "Error of Network Comes As No Surprise.\n"
    else
      result['forecasts'].each do |forecast|
        if forecast['temperature']['min'] != nil
          @min = forecast['temperature']['min']['celsius'].to_i
          @max = forecast['temperature']['max']['celsius'].to_i
          speak(@min.to_s)
          speak(@max.to_s)
        end
      end
    end
  end

  def emotion
    dif = @max - @min
    @mind += rand(-dif..dif)
    if @mind < 5
      @mind = 5
    end
    sleep(@base.fdiv(@mind))
  end

end
MAIN.new(ARGF.read).run
