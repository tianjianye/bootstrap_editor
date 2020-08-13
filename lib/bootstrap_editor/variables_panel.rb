return unless RUBY_ENGINE == 'opal'

module BootstrapEditor
  class VariablePanel < HyperComponent
    param :variable_array , default: []
    fires :variable_changed
    fires :type_changed
    render() {content}
    def content
      unless variable_array.nil?
        DIV(class:'col overflow-auto', style:{'gridColumn':'2','gridRow':'2'}) do
          FORM do
            variable_array.each do |variable|
              Input(variable: variable)
              .on(:value_changed) do |parameter|
                variable_changed!(parameter)
              end
              .on(:type_changed) do |parameter|
                type_changed!(parameter)
              end
            end
          end
        end
      end
    end
  end
end