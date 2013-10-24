require 'fileutils'
namespace :fake_service do
  task :load_server do
    print "Starting fake service."
    config = File.expand_path '../../config.ru', __FILE__
    FileUtils.mkpath("tmp/pids") unless File.directory?("tmp/pids")
    system "fake_service #{config} -p 4567 -P tmp/pids/fake_service.pid -D"
    begin
      url = URI('http://127.0.0.1:4567/')
      Net::HTTP.get(url)
      continue = true
    rescue Errno::ECONNREFUSED
      print "."
    end while !continue
    puts "Done!"
  end

  task :stop_server do
    puts "Stopping fake service."
    system "if [ -f tmp/pids/fake_service.pid ];\
             then kill `cat tmp/pids/fake_service.pid`; fi"
  end
end
