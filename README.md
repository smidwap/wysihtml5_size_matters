# Wysihtml5 Size Matters
Because size does matter.

With one simple plugin call, Wysihtml5 Size Matters makes your wysihtml5 editor automatically resize to fit the editor's content.

## Demo
You can view a demo of the plugin [here](http://smidwap.github.io/wysihtml5_size_matters/demo/index.html).

## Usage
Assuming you have jQuery in your project, include jquery.wysihtml5_size_matters.js

```html
<script src="path/to/jquery.wysihtml5_size_matters.js">
```

Initialize the plugin after initializing wysihtml5. You'll need to ensure the editor is loaded (i.e. in the DOM) before calling `wysihtml5_size_matters()`.

**Important:** `wysihtml5_size_matters()` expects to be attached to the editor's iframe, available via `editor.composer.iframe`

```js
var editor = new wysihtml5.Editor("wysiwyg", {
  toolbar:      "toolbarID"
});

editor.on('load', function() {
  // The wysiwyg editor is in the DOM. It's safe to make the plugin call
  $(editor.composer.iframe).wysihtml5_size_matters();
});
```

###Timer Option

The wysihtml5 relies on an iframe with a `<body contenteditable="true"></body>`.  The `contenteditabletrue` attribute provides `keyup` and `keydown` events, but there is currently no `change` event in the HTML5 spec.  Support for a comparable `input` event is very limited at this time.  This means that if your application programmatically changes the contents of the editor, the default, event-driven behavior won't catch the event and the height won't adjust.  This can also happen to users who use OS utilities such as [TextExpander](http://smilesoftware.com/TextExpander/index.html).

If your application needs to react to programmatically changing editor content, there is an option that uses `setInterval` instead of events to adjust the height.  If you pass in `useTimer: true`, the plugin will work this way.  Like so:

```js
editor.on('load', function() {
  //Now the height will automatically adjust despite how editor's contents were changed
  $(editor.composer.iframe).wysihtml5_size_matters({ useTimer: true });
});
```

Note that if you use this option, you must stop the timer in order to prevent an interval leak:

```js
//clears the interval
$(editor.composer.iframe).wysihtml5_size_matters("stopTimer");
```
