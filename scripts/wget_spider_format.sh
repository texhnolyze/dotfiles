grep -B 2 -E "(404 Not|500 Internal)" ~/wget.log | sed -e 's/^Proxy.*\. //' -e '/Connecting/d' -e  '/Reusing/d' -e 's/--$//'
