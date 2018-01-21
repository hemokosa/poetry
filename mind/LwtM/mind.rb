require 'net/http'
require 'uri'
require 'json'
require 'date'

class MAIN
  def initialize(src)
    @src = src
    @accum = 0
    @mind = 50
    @base = 50.0
    @min = 10
    @max = 20
    @code = ""
    @count = 0
    @th = []
    @tn = 0
    @inc = 1
    @com = "HhQqCcAaIiTtGgPp9Ff+-,.?<#,;!Ww _\n"
    @step = 0
    srand(Time.now.to_i)
  end

  def run
    loop {
      c = @src[@count]
      case c
      when /H|h/
        hello
      when /Q|q/
        print_source
      when /C|c/
        count_source
      when /A|a/
        sort_source
      when /I|i/
        introspection
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
      if @step >= 10000 then
        break
      end
      emotion
      }
  end

  private

  def hello
    puts "Hello, world!"
  end

  def print_source
    print @src
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
    }
  end

  def gbb
    fname = 'gbb.txt'
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    @accum.times{
      n = rand(line_count)
      File.open(fname).each_with_index { |line, index|
        print line.chop if index == n
      }
      print " "
    }
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
      puts "#{action}, #{after} of beer on the wall."
      puts "" unless k == 0
    end
  end


  def fizz_buzz
    1.upto(@accum) do |i|
      if i % 5 == 0 and i % 3 == 0
        puts "FizzBuzz"
      elsif i % 5 == 0
        puts "Buzz"
      elsif i % 3 == 0
        puts "Fizz"
      else
        puts i
      end
      sleep(1)
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
        sleep(@base/@mind/10.0)
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
    sleep(@base/@mind)
  end

end
MAIN.new(ARGF.read).run
