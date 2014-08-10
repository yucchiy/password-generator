(function() {
  'use strict';
  var app, restore;

  app = new Vue({
    el: '#password-generator',
    data: {
      generator: {
        master_token: '',
        length: '',
        interval: 2,
        prefix: 5
      },
      test: "",
      msg: {
        success: false,
        fail: false
      },
      validation: {
        master_token: false,
        length: false,
        prefix: true,
        interval: true
      }
    },
    filters: {
      tokenValidator: function(val) {
        this.validation.master_token = !!val;
        return val;
      },
      prefixValidator: function(val) {
        this.validation.prefix = val >= 0;
        return val;
      },
      intervalValidator: function(val) {
        this.validation.interval = val > 0;
        return val;
      },
      lengthValidator: function(val) {
        this.validation.length = val > 0;
        return val;
      }
    },
    methods: {
      save: function(e) {
        var that;
        e.preventDefault();
        this.generator.prefix = 5;
        this.generator.interval = 1;
        if (this.validation.master_token && this.validation.prefix && this.validation.interval && this.validation.length) {
          that = this;
          return chrome.storage.sync.set({
            master_token: this.generator.master_token,
            prefix: this.generator.prefix,
            interval: this.generator.interval,
            length: this.generator.length
          }, function() {
            that.msg.success = true;
            return that.msg.fail = false;
          });
        } else {
          that.msg.success = false;
          return that.msg.fail = true;
        }
      }
    }
  });

  restore = function() {
    return chrome.storage.sync.get({
      master_token: '',
      prefix: 5,
      interval: 1,
      length: 20
    }, function(items) {
      app.generator.master_token = items.master_token;
      app.generator.prefix = items.prefix;
      app.generator.interval = items.interval;
      return app.generator.length = items.length;
    });
  };

  restore();

}).call(this);
