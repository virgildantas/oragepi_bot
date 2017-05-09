MXEASY=$(ps -A | grep -w bot_telegram.rb)

if ! [ -n "$MXEASY" ] ; then
    cd /opt/orangepi_bot
    kill -9 $(cat bot_telegram.pid
    /usr/local/rvm/gems/ruby-2.4.0@bot_telegram/wrappers/ruby bot_telegram.rb &
fi
