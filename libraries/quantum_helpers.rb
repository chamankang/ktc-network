module KTC
  # Quantum helpers
  module Quantum
    def find_existing_entity(list_type, request_options)
      # change :null to nil
      refined_options = Hash[request_options.map { |k, v| [k, (v == :null ? nil : v)] }]
      # reject array type options  from request options because those cause
      # quantum internal server error
      refined_options.reject! { |k, v| v.kind_of? Array }
      response = send_request "list_#{list_type}", refined_options
      entity_list = response[:body][list_type]
      if entity_list.empty?
        entity = nil
      elsif entity_list.length == 1
        entity = entity_list[0]
      else
        msg = "Found multiple existing #{list_type}:\n" \
          "#{entity_list.join("\n")}\n" \
          "Need more specific options. Stop here."
        fail msg
      end
      entity
    end

    def store_id_in_attr(id, attr_path)
      attr_name = "node.set.#{attr_path}"
      # rubocop:disable Eval
      eval "#{attr_name} = '#{id}'"
      Chef::Log.info "Set #{attr_name} to '#{id}'"
    end

    def send_request(request, entity_options = {}, *args)
      options = Hash[entity_options.map { |k, v| [k.gsub(':', '_').to_sym, v] }]
      begin
        @quantum.send(request, *args, options)
      # rubocop:disable RescueException
      rescue Exception => e
        Chef::Log.error "An error occured with options: #{options}"
        raise e
      end
    end

    def get_id_from_macro(macro, search_map)
      macro_list = [:router, :network, :subnet, :port]
      if macro_list.include? macro
        if search_map.key? macro
          entity = find_existing_entity "#{macro.to_s}s", search_map[macro]
          id = entity['id']
        else
          fail "Must give :#{macro} options in 'search_id' attribute"
        end
      else
        fail "Macro must be one of #{macro_list}. You gave :#{macro}."
      end
      id
    end

    def compile_options(options, search_map)
      compiled_options = {}
      options.each do |k, v|
        if v.kind_of? Hash
          compiled_v = compile_options v, search_map
        elsif (v.kind_of? Symbol) && (v != :null)
          compiled_v = get_id_from_macro v, search_map
        else
          compiled_v = v
        end
        compiled_options[k] = compiled_v
      end
      compiled_options
    end

    def get_complete_options(default_options, resource_options)
      default_options.each do |k, v|
        if (v.nil?) && (!resource_options.key? k)
          fail(
            "Must give option \"#{k}\". Given options: #{resource_options}"
          )
        end
      end
      complete_options = default_options.clone
      complete_options.merge!(resource_options)
    end

    def need_update?(required_options, existing_options)
      !(required_options.to_a - existing_options.to_a).empty?
    end
  end
end
