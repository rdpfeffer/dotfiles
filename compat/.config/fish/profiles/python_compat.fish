# Some utilities like the python AWS cli tool hardcode the path to the python
# binary. The link below allows us to make the cli work
if not test -e /usr/local/opt/python/bin/python2.7
    echo "Adding symlink to python2.7 for compatibility"
    ln -s /usr/local/opt/python@2/bin/python2.7 /usr/local/opt/python/bin/python2.7
end
