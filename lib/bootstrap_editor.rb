require 'hyper-component'
require 'hyper-router'
require 'hyper-state'
require 'bootstrap_editor/engine'
Hyperstack.import 'bootstrap_editor'

if RUBY_ENGINE == 'opal'
  module BootstrapEditor
  end
  require 'bootstrap_editor/hyper_component'
  require 'bootstrap_editor/editor'
  require 'bootstrap_editor/input'
  require 'bootstrap_editor/error_message'
  require 'bootstrap_editor/preview'
  require 'bootstrap_editor/variables_panel'
  require 'bootstrap_editor/sass'
  require 'bootstrap_editor/javascripts/sass.js'
  require 'bootstrap_editor/javascripts/sass.worker.js'
else
  require 'opal'
  Opal.append_path(File.expand_path('../', __FILE__).untaint)
end