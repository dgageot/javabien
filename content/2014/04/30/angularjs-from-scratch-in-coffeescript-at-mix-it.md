---
title: "AngularJS from scratch, in CoffeeScript, at Mix-IT"
date: 2014-04-30T12:00:00+01:00
tags: []
---

Today at <a href="http://www.mix-it.fr/">Mix-IT</a>, I attended a nice workshop call <a href="http://www.mix-it.fr/session/424/angularjs-from-scratch">AngularJS from scratch</a>.

The idea is to let the participants develop, from scratch, AngularJS's code watch/digest mechanism.

First, I think it's a great idea to teach developers how to use a framework by letting them code a
simple version of the framework. I used to teach Spring IoC like that. Most of the time it works great.
It removes the fear people can face when using a "magical" tool like AngularJS.

Second, the workshop was well driven, with very easy steps. Good work guys.

Being myself, I thought it was a good opportunity not to code the thing in Javascript but rather
use CoffeeScript. Here's the code:

```coffee
# Scope
#
class Scope
  constructor: ->
    @$$watchers = []

  $watch: (watcherFn, listener, byValue = false) ->
    @$$watchers.push
      fn: watcherFn
      listener: listener
      byValue: byValue
      old: undefined

  $digest: ->
    for i in [1..10]
      return unless @$dirty_check()
    throw 'Digest is not stable'

  $dirty_check: ->
    console.log 'dirty_check'
    dirty = false
    for watcher in @$$watchers
      old = watcher.old
      value = watcher.fn(this)

      changed = if watcher.byValue then !_.isEqual(value, old) else (value != old)
      if changed
        watcher.listener(value, old, this)
        watcher.old = if watcher.byValue then _.clone(value) else value
        dirty = true
    dirty

  $apply: (fn) ->
    try
      fn()
    catch e
      console.log "Error caught in $apply: #{e}"
    finally
      @$digest()

# Directives
#
$$directives = {}
$directive = (name, value) ->
  if (value)
    $$directives[name] = value
  else
    $$directives[name]

$compile = (node, scope) ->
  for element in node.children
    $compile(element, scope)

  for attr in node.attributes
    directive = $directive(attr.name)
    if directive
      console.log 'Found directive ' + attr.name
      directive(scope, node, node.attributes)

# Application
#
scope = new Scope

$directive 'ng-bind', (scope, element, attrs) ->
  scope.$watch (scope) ->
    scope[attrs['ng-bind'].value]
  , (value) ->
    element.innerHTML = value

$directive 'ng-model', (scope, element, attrs) ->
  scope.$watch (scope) ->
    scope[attrs['ng-model'].value]
  , (value) ->
    element.value = value

  element.addEventListener 'keyup', ->
    scope.$apply ->
      scope[attrs['ng-model'].value] = element.value

$compile(document.body, scope)

scope.$apply ->
  scope.session = 'Zengular'
```
