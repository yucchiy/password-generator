'use strict';

app = new Vue {
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
      if @validation.master_token and @validation.prefix and @validation.interval and @validation.length
        chrome.storage.sync.set {
          master_token: @generator.master_token,
          prefix: @generator.prefix,
          interval: @generator.interval,
          length: @generator.length
        }, () ->
          console.log "Saved"
      else
        console.log "Todo: Error"
  }
}

restore = () ->
  chrome.storage.sync.get {
    master_token: MyUtil.randomStrings(10),
    prefix: 10,
    interval: 1,
    length: 10
  }, (items) ->
    app.generator.master_token = items.master_token
    app.generator.prefix = items.prefix
    app.generator.interval = items.interval
    app.generator.length = items.length

restore()

