return unless RUBY_ENGINE == 'opal'

module BootstrapEditor
  class Editor < HyperComponent
    include Hyperstack::Router::Helpers

    CLIENT_SIDE_COMPILATION = true
    param :reset_state, default: false
    param :save_state, default: false
    fires :reset_done
    fires :save_done
    render do
      if reset_state
        reset_event
        !reset_done!
      end
      DIV(class: 'mh-100',style: { display:'grid', 'gridTemplateRows': '5fr 95fr', 'gridTemplateColumns': '9fr 3fr' } ) do
        header
        BootstrapEditor::Preview(path_preview: '/bootstrap_editor_preview.html')
        variable_panel
        loader
        BootstrapEditor::ErrorMessage()
      end
    end

    after_mount do
      init
    end


    def variable_file_event(result)
      @import_variable_file = result
      update_variables(@import_variable_file)
      mutate
      compile_css(initial: false)
    end

    def custom_file_event(result)
      @custom_file = result
      compile_css(initial: false)
    end

    def reset_event
      show_loader
      initial_variables
      update_preview(@default_css_string)
      hide_loader
    end

    # components
    def header(variable_array)
      BootstrapEditor::Header(variable_array: variable_array,css_string: @css_string, export_variable_file: @export_variable_file, custom_file: @custom_file)
      .on(:variable_file_changed) do |result|
        variable_file_event(result)
      end.on(:custom_file_changed) do |variable|
        custom_file_event(result)
      end.on(:reset_event) do
        reset_event
        mutate @reset = false
      end
    end

    def variable_panel
      BootstrapEditor::VariablePanel(variable_array: @variable_array).on(:variable_changed) do |variable|
        change_variable_value(variable)
      end.on(:type_changed) do |variable|
        change_variable_type(variable)
      end
    end
    def loader
      DIV(id: 'loader', class: 'spinner-border position-absolute',style:{ display: "none", top: "50%", left: "50%", width: "6em", height: "6em" }) do
        SPAN(class: 'sr-only') do
        end
      end
    end


    # methods
    def init
      show_loader
      HTTP.get("/functions.scss") do |res_func|
        @functions = res_func.body
        HTTP.get("/flat_bootstrap.scss") do |res_bootstrap|
          @bootstrap =  res_bootstrap.body
          HTTP.get("/default_variable.scss") do |res_var|
            @default_variable_file =  res_var.body
            # store the default variables array
            @default_variable_ast = Sass.parse(@default_variable_file)
            @ast = @default_variable_ast.duplicate
            @default_variable_array = @default_variable_ast.find_declaration_variables
            initial_variables
            compile_css(initial: true)
            mutate
          end
        end
      end
    end

    def update_variables(import_variable_file)
      # write import variable file into variable file
      @import_variable_array = Sass.parse(import_variable_file).find_declaration_variables
      @import_variable_array.each do |item|

        if @default_variable_array.map {|x| x.values[1]}.uniq.include?(item['name'])
          @old_variable_array.push(item)
        else
          @new_variable_array.push(item)
        end
      end

      @old_variable_array = remove_duplicate(@old_variable_array)
      @new_variable_array = remove_duplicate(@new_variable_array)

      @old_variable_array.each do |item|
        @ast.replace(item)
      end

      @variable_name_array = @variable_array.map {|x| x.values[1]}.uniq

      @new_variable_array.each do |item|
        if @variable_name_array.include?(item['name'])
          @ast.replace(item)
        else
          @ast.add(item,@new_variable_array.index(item))
        end
      end
      @variable_file = @ast.stringify
      @export_variable_file = @ast.find_changed_value
      @variable_array = @ast.find_declaration_variables
    end

    def remove_duplicate(array)
      new_array = []
      variable_name_array = array.map {|x| x.values[1]}.uniq
      variable_name_array.each do |item_name|
        target = array.select{|x| x['name'] == item_name}
        new_array.push(target.last)
      end
      return new_array
    end

    def change_variable_value(variable)
      @timer&.abort
      @timer = after(1) do
        # add the changed value to variable file
        @ast.replace(variable)
        @variable_file = @ast.stringify
        @export_variable_file = @ast.find_changed_value
        target = @variable_array.find {|x| x['name'] == variable['name']}
        target['value'] = variable['value']
        target['unit'] = variable['unit']
        compile_css(initial: false)
        @timer = nil
      end
    end

    def update_preview(css_string)
      return unless css_string.present?
      `
        var frame = top.document.querySelector('iframe');
        frame.contentWindow.postMessage(#{css_string},'/');
      `
    end

    def initial_variables
      # init custom file and variable file
      @custom_file = ""
      @import_variable_file = ""
      @export_variable_file = ""
      # array to stock all the variables changed
      @ast = @default_variable_ast.duplicate
      ::Element.find('#fileVariable').val("")
      ::Element.find('#fileCustom').val("")
      # init ast and array
      @variable_array = clone_deep(@default_variable_array)
      @old_variable_array = []
      @new_variable_array = []
      mutate
    end

    def clone_deep(object)
      @result = `lodash.cloneDeep(#{object});`
      return @result
    end

    def compile_css(options = {})
      # compile as a css string
      show_loader
      if options[:initial]
        @combinaison = @functions.to_s + "\n"+ @default_variable_file.to_s + "\n" + @bootstrap.to_s + "\n"
      else
        @combinaison = @functions.to_s + "\n"+ @variable_file.to_s + "\n" + @bootstrap.to_s + "\n" + @custom_file.to_s + "\n"
      end
      after(0) do
        if CLIENT_SIDE_COMPILATION
          Sass.compile(@combinaison) do |result|
            unless result.nil?
              if result['status']==1
                # show error message
                show_error(result['message'].to_s)
              else
                # return css string and apply it into the iframe
                @css_string = result['text']
                if options[:initial]
                  @default_css_string  = @css_string
                end
                update_preview(@css_string)
              end
              mutate
              hide_loader
            end
          end
        else
          HTTP.post("/compile_css", payload: {scss: @combinaison}) do |response|
            if response.json['status'] != 'ok'
              # show error message
              show_error(result['message'].to_s)
            else
              # return css string and apply it into the iframe
              @css_string = response.json['message'].to_s
              if options[:initial]
                @default_css_string  = @css_string
              end
              update_preview(@css_string)
            end
            mutate
            hide_loader
          end
        end
      end
    end

    def show_error(error_message)
      `
      $(".toast").show();
      $("#error").html(#{error_message});
      $(".toast").toast('show');
      `
    end

    def show_loader
      ::Element.find('#loader').show()
    end

    def hide_loader
      ::Element.find('#loader').hide()
    end

    def change_variable_type(variable)
      target = @variable_array.find{|item| item['name'] == variable['name']}
      target['type'] = variable['type']
    end

  end
end
