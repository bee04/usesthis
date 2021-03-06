# frozen_string_literal: true

module UsesThis
  # A class that models a single link on the site.
  class Link
    attr_accessor :slug
    attr_accessor :name
    attr_accessor :url
    attr_accessor :description

    def initialize(path)
      metadata = YAML.load_file(path)

      @slug = File.basename(path, File.extname(path))
      @name = metadata['name']
      @url = metadata['url']
      @description = metadata['description'] || ''
    end

    def inspect
      "#<#{self.class.to_s} " \
      "@slug=#{@slug} " \
      "@name=#{@name} " \
      "@url=#{@url} " \
      "@description=#{@description}>"
    end
  end
end
