return unless RUBY_ENGINE == 'opal'

module BootstrapEditor
  class Header < HyperComponent
    param :variable_array
    param :css_string
    param :export_variable_file
    param :custom_file
    fires :variable_file_changed
    fires :custom_file_changed
    fires :reset_variable

    render do
      DIV(class:"d-flex pl-3 pr-3 mb-2 mt-2",style:{"gridColumnStart":"1","gridColumnEnd":"3"}) do
        input_variable_file
        input_custom_file
        download(css_string, export_variable_file, custom_file)
        spacer
        reset
      end
    end

    def input_variable_file
      DIV(class:'input-group w-auto mr-1') do
        DIV(class:'custom-file') do
          INPUT(type: :file, class: 'custom-file-input', id:"fileVariable").on(:change) do |evt|
            @file = evt.target.files[0]
            unless @file.nil?
              @file_content = @file.text()
              @file_content.then{|result|
                variable_file_changed!(result)
              }
            end
          end
          LABEL(class:"custom-file-label", htmlFor:'fileVariable'){"Variable File"}
        end
      end
    end

    def input_custom_file
      DIV(class:'input-group mr-1 w-auto') do
        DIV(class:'custom-file') do
          INPUT(type: :file,class: 'custom-file-input', id:"fileCustom").on(:change) do |evt|
            @file = evt.target.files[0]
            unless @file.nil?
              @file_content = @file.text()
              @file_content.then{|result|
                custom_file_changed!(result)
              }
            end
          end
          LABEL(class:"custom-file-label", htmlFor:'fileCustom'){"Custom File"}
        end
      end
    end

    def reset
      DIV(class:"mr-1") do
        BUTTON(class:'btn btn-danger'){"Reset"}.on(:click) do
          reset_variable!
        end
      end
    end

    def spacer
      DIV(class:"flex-grow-1") do

      end
    end

    def download(css_string, export_variable_file, custom_file)
      @file_list =
      [
        {'name' => 'bootstrap.css','content' => css_string.to_s},
        {'name' => 'variable.scss','content' => export_variable_file.to_s},
        {'name' => 'custom.scss','content' => custom_file.to_s}
      ]
      DIV(class:"mr-1") do
        BUTTON(type: :button,class:"btn btn-outline-primary dropdown-toggle",'data-toggle':"dropdown",'aria-haspopup':"true",'aria-expanded':"false"){"Download"}
        DIV(class:"dropdown-menu") do
          @file_list.each do |file|
            A(class:"dropdown-item",href:"#"){file['name']}.on(:click) do |evt|
              evt.prevent_default
              `download(#{file['content']}, #{file['name']}, "text/plain");`
            end
          end
        end
      end
    end

  end
end