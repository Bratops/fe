# Karma configuration
# http://karma-runner.github.io/0.10/config/configuration-file.html
module.exports = (config) ->
  config.set

    # base path, that will be used to resolve files and exclude
    basePath: ""
    # testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ["jasmine"]
    # list of files / patterns to load in the browser
    files: [
      "client/blib/jquery/dist/jquery.js"
      "client/blib/angular/angular.js"
      "client/blib/angular-mocks/angular-mocks.js"
      "client/blib/angular-resource/angular-resource.js"
      "client/blib/angular-cookies/angular-cookies.js"
      "client/blib/angular-sanitize/angular-sanitize.js"
      "client/blib/angular-route/angular-route.js"
      "client/blib/angular-bootstrap/ui-bootstrap-tpls.js"
      "client/blib/lodash/dist/lodash.compat.js"
      "client/blib/angular-ui-router/release/angular-ui-router.js"
      "client/blib/restangular/dist/restangular.js"
      "client/blib/angular-scroll/angular-scroll.js"
      "client/blib/angular-growl-v2/build/angular-growl.js"
      "client/app/app.js"
      "client/app/app.coffee"
      "client/app/**/*.js"
      "client/app/**/*.coffee"
      "client/components/**/*.js"
      "client/components/**/*.coffee"
      "client/app/**/*.jade"
      "client/components/**/*.jade"
      "client/app/**/*.html"
      "client/components/**/*.html"
    ]
    preprocessors:
      "**/*.jade": "ng-jade2js"
      "**/*.html": "html2js"
      "**/*.coffee": "coffee"
    ngHtml2JsPreprocessor:
      stripPrefix: "client/"
    ngJade2JsPreprocessor:
      stripPrefix: "client/"
    # list of files / patterns to exclude
    exclude: []
    # web server port
    port: 8080
    # level of logging
    # possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO
    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: false
    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: ["PhantomJS"]
    # Continuous Integration mode
    # if true, it capture browsers, run tests and exit
    singleRun: false
  return
