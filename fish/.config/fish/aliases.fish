function up
  ping 8.8.8.8
end

function battery
  pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';'
  pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f3 -d';'
end

function cpu
  sysctl -n machdep.cpu.brand_string
end

function ip
  dig +short myip.opendns.com @resolver1.opendns.com
end

function ss
  open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app
end

function lock
  /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
end

function uptime
  command grc uptime
end

function fortune
  command fortune $argv | lolcat
end

function df --description 'Displays disk free space'
  command df -H $argv
end

function cake
  command em sparkles cake sparkles
end

function super-cake
  command em dizzy sparkles cake sparkles dizzy
end

function pyc
  command find . -name "*.pyc" -exec rm -rf {} \;
end

function large_files --description 'Show the ten largest files'
  command du -d 1 -h $argv | sort -h | tail
end
