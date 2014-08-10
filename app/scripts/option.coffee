'use strict';

app = new Vue {
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
      length: false
      prefix: true,
      interval: true,
    }
  },
  filters: {
    tokenValidator: (val) ->
      @validation.master_token = !!val
      return val
    ,prefixValidator: (val) ->
      @validation.prefix = (val >= 0)
      return val
    ,intervalValidator: (val) ->
      @validation.interval = (val > 0)
      return val
    ,lengthValidator: (val) ->
      @validation.length = (val > 0)
      return val
  },
  methods: {
    save: (e) ->
      e.preventDefault()
      @generator.prefix = 5
      @generator.interval = 1
      if @validation.master_token and @validation.prefix and @validation.interval and @validation.length
        that = @
        chrome.storage.sync.set {
          master_token: @generator.master_token,
          prefix: @generator.prefix,
          interval: @generator.interval,
          length: @generator.length
        }, () ->
          that.msg.success = true
          that.msg.fail = false
      else
        that.msg.success = false
        that.msg.fail = true
  }
}

restore = () ->
  chrome.storage.sync.get {
    master_token: '',
    prefix: 5,
    interval: 1,
    length: 20
  }, (items) ->
    app.generator.master_token = items.master_token
    app.generator.prefix = items.prefix
    app.generator.interval = items.interval
    app.generator.length = items.length

restore()

