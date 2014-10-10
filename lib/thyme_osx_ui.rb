require "thyme_osx_ui/version"
require "open3"
require "pathname"

module ThymeOSX

  class UI

    def initialize
      executable_path = Pathname.new(__FILE__)
          .parent.parent
          .join("ext/pomodoro_statusbar/pomodoro_statusbar")
          .to_path
      @stdin, @stdout, @status = Open3.popen2(executable_path)
    end

    def tick(seconds_left)
      if !@status.status && !@status.value.success?
        Process.kill("TERM", 0)
      else
        @stdin.puts text(seconds_left)
      end
    end

    def destroy
      @stdin.close
      @stdout.close
      Process.kill("TERM", @status.pid) if @status.status
    end

    def text(seconds_left)
      "#{emoji(seconds_left)} #{format_time(seconds_left)}"
    end

    def format_time(seconds_left)
      "%d:%02d" % [seconds_left / 60, seconds_left % 60]
    end

    def emoji(seconds_left)
      if seconds_left < 60
        if seconds_left.odd?
          "🔴 "
        else
          "⚪️ "
        end
      elsif seconds_left < 2 * 60
        "1️⃣ "
      elsif seconds_left < 3 * 60
        "2️⃣ "
      elsif seconds_left < 4 * 60
        "3️⃣ "
      elsif seconds_left < 5 * 60
        "4️⃣ "
      elsif seconds_left < 6 * 60
        "5️⃣ "
      else
        "🍅 "
      end
    end

  end

end
