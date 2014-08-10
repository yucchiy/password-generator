'use strict';

class @MyUtil
  @randomStrings: (length) ->
    _.sample('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'.split(''), length).join('')


