# Bootstrap Editor Gem

## Pre-Requisites

* Rails 5.x
* Yarn
* Environment Linux

## Installation

### Ruby on Rails

* Add `bootstrap_editor`, `bootstrap` and  `font-awesome-sass` gems to your Gemfile:
```ruby
gem 'bootstrap_editor'
gem 'bootstrap'
gem 'font-awesome-sass'
```

* Then `bundle install` and restart your server to make the files available through the pipeline.

* Add `popper`, `bootstrap-sprockets` and `bootstrap_editor` in `app/assets/javascript/application.js`:
```js
//= require popper
//= require bootstrap-sprockets
//= require bootstrap_editor
```

* Import bootstrap and font-awesome in `app/assets/stylesheets/application.scss`:
```scss
@import 'bootstrap';
@import 'font-awesome-sprockets';
@import 'font-awesome';
```

* add node modules with yarn:
```console
yarn add scss-parser
yarn add query-ast
yarn add lodash
yarn add react-color
yarn add downloadjs
```
* rewrite `hyperstack.js` in `app/javascript/packs`
```js
import {parse,stringify} from 'scss-parser';
import createQueryWrapper from 'query-ast';
import lodash from 'lodash';
import { SketchPicker } from 'react-color';
import downloadjs from 'downloadjs';

global.parse = parse;
global.stringify = stringify;
global.createQueryWrapper = createQueryWrapper;
global.lodash = lodash;
global.SketchPicker = SketchPicker;
global.download = downloadjs;
```

## Usage

* You can use `BootstrapEditor::Editor` with parameters variable_file, custom_file and reset in a hyperstack project to add the editor:

```
variable_file: string; // default value is empty string
custom_file: string; // default value is empty string
reset: boolean; // default value is false, if reset is true, the style of the editor will be reset
```
but it's necessary to fix the height of the editor, for example:
```ruby
DIV(style: {height: 'calc(100vh)'}) do
  BootstrapEditor::Editor(reset: false, custom_file: "", variable_file: "$white: #823838;")
end
```

* You can also use it without parameters, for example:
```ruby
DIV(style: {height: 'calc(100vh)'}) do
  BootstrapEditor::Editor()
end
```