---
title: "AngularJs and CoffeeScript"
date: 2014-02-25T12:00:00+01:00
tags: ["angularjs","coffeescript","java"]
---

Ok, now everybody know I love Java 8. But I also love <a href="http://coffeescript.org/">CoffeeScript</a> when it comes to web development. I think it is much easier to read than Javascript. Maybe its because I also love Ruby...

I also like <a href="http://angularjs.org/">AngularJs</a> a lot. Despite the fact that it's a full fledge framework (which I tend to dislike), I really enjoy using it. But I still have a lot to learn...

Now knowing that I love both Coffee and Angular, the first thing I tried, of course, was to use both.

<blockquote>
  Here's what a Controller looks like:
</blockquote>

**app.coffee**

```coffee
angular.module 'myapp', []

.controller 'DemoController', class
	constructor: (@$location) ->
		@field = 'Field'

	method: ->
		'Method'

	methodWithParam: (param) ->
		"Param: #{param}"

	accessFieldFromMethod: ->
		"Path: #{@$location.absUrl()}"```

**test.html**

```html
<!DOCTYPE html>
<html lang="en" ng-app="myapp">
<head>
  <meta charset="UTF-8">
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular.min.js"></script>
  <script src="app.coffee"></script>
</head>
<body ng-controller="DemoController as demo">
<p>{{demo.field}}</p>

<p>{{demo.method()}}</p>

<p>{{demo.methodWithParam('param1')}}</p>

<p>{{demo.accessFieldFromMethod()}}</p>
</body>
</html>
```

I think its nice and easy to read. It uses the new "Controller as" syntax in Angular to better isolate the different scopes.

Be careful though: the html sample will work only if your web server converts coffee to js on the fly. Otherwise, you have to do the compilation on client side using <code>coffee-script.js</code> script.
