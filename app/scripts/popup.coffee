'use strict';

app = new Vue {
  el: '#password-generator',
  methods: {
    generate: ->
      user = @user
      chrome.storage.sync.get {
        master_token: 'deMCP0Dsj8Kh',
        prefix: 10,
        interval: 1,
        length: 10
      }, (items) ->
        pass = _.without(
          base64_encode(pack('H*', md5(user.username + "@" + user.domain + ":" + items.master_token))).split(''),
          '+', '/', '='
        )

        user.password = _.filter(
          pass.slice(items.prefix).join('')
          ,(val, idx) -> return idx % items.interval == 0
        ).join('').substring(0, items.length)

  },
  data: {
    user: {
      domain: '',
      username: '',
      password: ''
    }
  },
}

if chrome.tabs
  chrome.tabs.getSelected window.id, (tab) ->
    app.user.domain = URI(tab.url).domain()

