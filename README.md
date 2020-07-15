# Bootstrap Editor Gem
## Installation

### Ruby on Rails

* Add bootstrap_editor to your Gemfile:
```
gem 'bootstrap_editor'
```

* Then `bundle install` and restart your server to make the files available through the pipeline.

* Import `bootstrap_editor` in `app/assets/javascript/application.js`:
```
//= require bootstrap_editor
```

And import `popper` before `turbolinks`:
```
//= require popper
//= require turbolinks
```

* Import bootstrap and font-awesome in `app/assets/stylesheets/application.scss`:
```
@import 'bootstrap';
@import 'font-awesome-sprockets';
@import 'font-awesome';
```

* add node modules with yarn:
```
yarn add scss-parser
yarn add query-ast
yarn add lodash
yarn add react-color
yarn add downloadjs
```
* rewrite `hyperstack.js` in `app/javascript/packs`
```
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