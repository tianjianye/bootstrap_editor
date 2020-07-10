return unless RUBY_ENGINE == 'opal'

module BootstrapEditor
  class Editor < HyperComponent
    render do
      DIV{'============='}
    end
  end
end
