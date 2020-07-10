return unless RUBY_ENGINE == 'opal'

module BootstrapEditor
  class App < HyperComponent
    # include Hyperstack::Router
    # include Hyperstack::Router::Helpers
    render do
      BootstrapEditor::Editor()
    end
  end
end
