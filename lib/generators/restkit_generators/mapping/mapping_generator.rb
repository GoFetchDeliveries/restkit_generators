module RestkitGenerators
  class MappingGenerator < IosModelGenerator
    source_root File.expand_path('../templates', __FILE__)

    def generate_mapping_protocol
      template "interface.h.erb",       destination_path("#{filename}.h")
      template "implementation.m.erb",  destination_path("#{filename}.m")
    end

    private

    def filename
      ios_base_class_name + "+" + category_name
    end

    def category_name
      "Mapping"
    end
  end
end