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
        pass = _.without(
          base64_encode(pack('H*', md5(user.username + "@" + user.domain + ":" + items.master_token))).split(''),
          '+', '/', '='
        )

        user.password = _.filter(
          pass.slice(items.prefix).join('')
          ,(val, idx) -> return idx % items.interval == 0
        ).join('').substring(0, items.length)
    showPassword: (event) ->
      event.target.setAttribute 'type', 'text'
    hidePassword: (event) ->
      event.target.setAttribute 'type', 'password'
    copyToClipboard: ->
      ta = document.createElement 'textarea'
      ta.style.cssText = "position:absolute;left:-100%"
      document.body.appendChild ta
      ta.value = @user.password
      ta.select()
      document.execCommand 'copy'
      document.body.removeClild ta
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

