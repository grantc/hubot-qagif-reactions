# Description:
#   DevOps reactions
#
# Dependencies:
#   jsdom
#
# Configuration:
#   None
#
# Commands:
#   qagif reactions
#
# Author:
#

jsdom = require('jsdom').jsdom
jquery = 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'
url = 'http://qagif.tumblr.com/random'
qagifRegex = /(qagif reactions|!qagif)/i

module.exports = (robot) ->
  robot.hear qagifRegex, (msg) ->
    msg.http(url).get() (err, res, body) ->
      location = res.headers.location
      jsdom.env location, [jquery], (errors, window) ->
        (($) ->
          title = $('.post_title').text()
          image = $('.item img').attr('src')

          if title and image
            msg.send "#{title}"
            msg.send "#{image}"
        )(window.jQuery)
