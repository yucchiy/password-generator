(function() {
  'use strict';
  var app;

  app = new Vue({
    el: '#password-generator',
    methods: {
      generate: function() {
        var user;
        user = this.user;
        return chrome.storage.sync.get({
          master_token: '',
          prefix: 5,
          interval: 1,
          length: 20
        }, function(items) {
          var pass;
          pass = _.without(base64_encode(pack('H*', md5(user.username + "@" + user.domain + ":" + items.master_token))).split(''), '+', '/', '=');
          return user.password = _.filter(pass.slice(items.prefix).join(''), function(val, idx) {
            return idx % items.interval === 0;
          }).join('').substring(0, items.length);
        });
      },
      showPassword: function(event) {
        return event.target.setAttribute('type', 'text');
      },
      hidePassword: function(event) {
        return event.target.setAttribute('type', 'password');
      },
      copyToClipboard: function() {
        var ta;
        ta = document.createElement('textarea');
        ta.style.cssText = "position:absolute;left:-100%";
        document.body.appendChild(ta);
        ta.value = this.user.password;
        ta.select();
        document.execCommand('copy');
        return document.body.removeClild(ta);
      }
    },
    data: {
      user: {
        domain: '',
        username: '',
        password: ''
      },
      initialized: false
    }
  });

  chrome.storage.sync.get({
    'master_token': null
  }, function(items) {
    return app.initialized = items.master_token !== null;
  });

  if (chrome.tabs) {
    chrome.tabs.getSelected(window.id, function(tab) {
      return app.user.domain = URI(tab.url).domain();
    });
  }

}).call(this);
