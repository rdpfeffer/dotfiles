function up
    ping 8.8.8.8 $argv
end

function battery
    pmset -g batt
end

function cpu
    sysctl -n machdep.cpu.brand_string
end

function ip
    dig +short myip.opendns.com @resolver1.opendns.com
end

function lock
    # Use the macOS Lock Screen shortcut.
    osascript -e 'tell application "System Events" to keystroke "q" using {control down, command down}'
end

function df --description 'Displays disk free space'
    command df -H $argv
end

function pyc --description 'Remove Python bytecode files below the current directory'
    command find . -type f -name '*.pyc' -delete
end

function large_files --description 'Show the ten largest files'
    command du -d 1 -h $argv | sort -h | tail
end

function dim --description 'Alias for git diff'
    command git diff $argv
end

function dimc --description 'Alias for git diff --cached'
    command git diff --cached $argv
end

function k --description 'Alias for kubectl'
    command kubectl $argv
end
