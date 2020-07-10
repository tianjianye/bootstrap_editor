return unless RUBY_ENGINE == 'opal'

module BootstrapEditor
  class Preview < HyperComponent
    param :src_html
    render do
      IFRAME(class:"w-100 h-100 border-0", style:{'gridArea': ' 2 / 1 / auto / auto'}, src: src_html)
    end
  end
end