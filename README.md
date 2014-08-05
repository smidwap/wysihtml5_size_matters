# Wysihtml5 Size Matters
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
