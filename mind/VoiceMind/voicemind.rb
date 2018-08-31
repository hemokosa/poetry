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
    @com = "HhQqCcSsIiDdTtGgRrPpVvFfEeKk+-.?!>#;,^()*@<~=$%&Ww _\n"
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
      when /C|c/
        count_source
      when /S|s/
        sort_source
      when /I|i/
        introspection
      when /D|d/
        infrathins
      when /T|t/
        truisms
      when /G|g/
        gbb
      when /R|r/
        rnd
      when /P|p/
        prophecy
      when /V|v/
        verse
      when /F|f/
        finnegan
      when /E|e/
        emotions
      when /K|k/
        kardashian
      when /\+|\(/
        increment
      when /-|\)/
        decrement
      when /\.|\*/
        top
      when /\?|@/
        jump
      when /!|</
        back
      when />|~/
        rev
      when /#|=/
        go
      when /;|\$/
        append
      when /,|%/
        overwrite
      when /\^|&/
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

  def read(file, n)
    fname = file
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    n.times{
      l = rand(line_count)
      File.open(fname).each_with_index { |line, index|
        puts line if index == l
        speak(line) if index == l
      }
    }
  end

  def hello
    txt = "Hello, " + ["World", "Space", "Hackney", "Coding", "Human", "Again"].sample + "!"
    puts txt
    speak(txt)
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
        # print key, " ", value, " "
        print key, " "
        speak(key)
        # speak(value)
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
    read('infrathins.txt', 1)
  end

  def truisms
    read('truisms.txt', 1)
  end

  def gbb
    fname = 'gbb.txt'
    fp = open(fname,'r')
    line_count = 0
    while fp.gets
      line_count += 1
    end
    (@accum + rand(9)).times{
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

  def rnd
    o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    n = rand(3..6)
    l = rand(4..8)
    n.times{
      l = rand(4..8)
      txt = (0...l).map { o[rand(o.length)] }.join
      print txt + " "
      speak(txt)
    }
    puts
  end

  def prophecy
    read('prophecy.txt', 4)
  end

  def verse
    read('verse.txt', 4)
  end

  def finnegan
    read('finnegan.txt', 1)
  end

  def emotions
    read('emotions.txt', 1)
  end

  def kardashian
    term = "Kim+Kardashian+Marriage"
    url = "http://www.google.com/search?num=100&hl=en&q=" + term
    page = open url
    doc = Nokogiri::HTML page

    n = rand(99)
    doc.search('h3 a').each_with_index do |phrase, index|
      puts phrase.inner_text if index == n
      speak(phrase.inner_text) if index == n
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
        # puts(forecast['telop'])
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
