(function() {
  'use strict';
  var app, restore;

  app = new Vue({
    el: '#password-generator',
    data: {
      generator: {
        master_token: '',
        prefix: '',
        interval: '',
        length: ''
      },
      validation: {
        master_token: false,
        prefix: false,
        interval: false,
        length: false
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
        e.preventDefault();
        if (this.validation.master_token && this.validation.prefix && this.validation.interval && this.validation.length) {
          return chrome.storage.sync.set({
            master_token: this.generator.master_token,
            prefix: this.generator.prefix,
            interval: this.generator.interval,
            length: this.generator.length
          }, function() {
            return console.log("Saved");
          });
        } else {
          return console.log("Todo: Error");
        }
      }
    }
  });

  restore = function() {
    return chrome.storage.sync.get({
      master_token: MyUtil.randomStrings(10),
      prefix: 10,
      interval: 1,
      length: 10
    }, function(items) {
      app.generator.master_token = items.master_token;
      app.generator.prefix = items.prefix;
      app.generator.interval = items.interval;
      return app.generator.length = items.length;
    });
  };

  restore();

}).call(this);
