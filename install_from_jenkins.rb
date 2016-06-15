require 'jenkins_api_client'

branch = ARGV[0]
build_number = ARGV[1]
server_ip = '127.0.0.1'
username = 'domain\username'
password = 'password'
branch = 'development' if branch.nil?
build_name = "K-PAX - branch #{branch}"
jenkins_path = '\\\\FP-PC2782\\Jenkins\\jobs'


def get_latest_build_number(branch)
  @client = JenkinsApi::Client.new(:server_ip => server_ip, :username => username, :password => password)
  return @client.job.get_current_build_number(build_name)
rescue => exception
  puts 'It is impossible to get latest build number!'
  puts exception.backtrace
  exit
end


build_number = get_latest_build_number(branch) if build_number.nil?

puts "#{branch} ##{build_number}"
puts 'Copying files from Jenkins archives'
file_path = "\"#{jenkins_path}\\#{build_name}\\builds\\#{build_number}\\archive\\app\\build\\outputs\\apk\\app-release.apk\""
output = `copy #{file_path} %cd%`
puts output
puts 'Reinstalling K-PAX'
`adb uninstall no.solid.commissioning`
`adb install app-release.apk`
