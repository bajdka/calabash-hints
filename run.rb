feature = ARGV[0]

scenario_number = ARGV[1]
`adb start-server`
adb_devices = `adb devices`

# TO DO: getting device IP
device_serial_no = (/\w*\d\w*/).match(adb_devices)

if device_serial_no.nil?
  puts 'No device connected'
  exit
else
  puts "* Device serial no.: #{device_serial_no} *"
end

if feature.include? '@'
  scenario_tag = feature
  test_scenario = "--tags #{scenario_tag}"
else
  if scenario_number.nil?
    test_scenario = "features\\#{feature}_activity.feature"
  else
    test_scenario = "features\\#{feature}_activity.feature:#{scenario_number}"
  end
end

test_scenario = '' if feature == 'all'

cmd = "calabash-android run app-debug.apk #{test_scenario} --format html --out report.html --format pretty --verbose ADB_DEVICE_ARG=#{device_serial_no}"

puts '* Test execution starts *'
puts "* #{cmd} *"
system(cmd)
