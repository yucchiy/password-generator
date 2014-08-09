(function() {
  'use strict';
  this.MyUtil = (function() {
    function MyUtil() {}

    MyUtil.randomStrings = function(length) {
      return _.sample('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'.split(''), length).join('');
    };

    return MyUtil;

  })();

}).call(this);
