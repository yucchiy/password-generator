'use strict';

app = new Vue {
  el: '#password-generator',
  methods: {
    generate: ->
      @user.password = base64_encode(pack('H*', md5(@user.username + "@" + @user.domain)))
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

