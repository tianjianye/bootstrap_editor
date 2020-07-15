return unless RUBY_ENGINE == 'opal'

module BootstrapEditor
  class App < HyperComponent
    include Hyperstack::Router
    include Hyperstack::Router::Helpers
    render(DIV, style: {height: '100vh',width: '100vh'}) do
      BootstrapEditor::Editor()
    end
  end
end
