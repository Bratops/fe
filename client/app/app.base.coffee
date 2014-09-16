class @AppBase

  @register: (app, provider, name) ->
    name ?= @name || @toString().match(/function\s*(.*?)\(/)?[1]
    app[provider](name, this)

  @inject: (annotations...) ->
    ANNOTATION_REG = /^(\S+)(\s+as\s+(\w+))?$/
    @annotations = _.map annotations, (annotation) ->
      match = annotation.match(ANNOTATION_REG)
      name: match[1], identifier: match[3] or match[1]
    @$inject = _.map @annotations, (annotation) -> annotation.name

  constructor: (dependencies...) ->
    if dependencies.length
      for annotation, index in @constructor.annotations
        this[annotation.identifier] = dependencies[index]
    @initialize?()

