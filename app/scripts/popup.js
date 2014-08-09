(function() {
  'use strict';
  var app;

  app = new Vue({
    el: '#password-generator',
    methods: {
      generate: function() {
        return this.user.password = base64_encode(pack('H*', md5(this.user.username + "@" + this.user.domain)));
      }
    },
    data: {
      user: {
        domain: '',
        username: '',
        password: ''
      }
    }
  });

  if (chrome.tabs) {
    chrome.tabs.getSelected(window.id, function(tab) {
      return app.user.domain = URI(tab.url).domain();
    });
  }

}).call(this);
