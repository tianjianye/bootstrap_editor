
require 'hyper-component'
Hyperstack.import 'bootstrap_editor'

if RUBY_ENGINE == 'opal'

  module BootstrapEditor
  end

  require 'bootstrap_editor/hyper_component'
  require 'bootstrap_editor/editor'
  require 'bootstrap_editor/input'

else
  require 'opal'
  Opal.append_path(File.expand_path('../', __FILE__).untaint)
end
