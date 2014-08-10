'use strict';

app = new Vue {
  el: '#password-generator',
  methods: {
    generate: ->
      user = @user
      chrome.storage.sync.get {
        master_token: '',
        prefix: 5,
        interval: 1,
        length: 20
      }, (items) ->
        if items.master_token == ''
          items.master_token = MyUtil.randomStrings(20)
          chrome.storage.sync.set {
            master_token: items.master_token,
            prefix: items.prefix,
            interval: items.interval,
            length: items.length
          }, () ->
            console.log "saved"

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
    },
    initialized: false
  },
}

chrome.storage.sync.get {'master_token': null}, (items) ->
  app.initialized = items.master_token isnt null

if chrome.tabs
  chrome.tabs.getSelected window.id, (tab) ->
    app.user.domain = URI(tab.url).domain()

