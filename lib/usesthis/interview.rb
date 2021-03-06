# frozen_string_literal: true

module UsesThis
  # A class that models a single interview.
  class Interview < Dimples::Post
    attr_accessor :hardware
    attr_accessor :software
    attr_accessor :credits
    attr_accessor :license

    def initialize(site, path)
      super

      @layout = 'interview'

      @hardware = []
      @software = []

      scan_links
    end

    def contents
      super + "\n\n" + gear_links
    end

    def gear_links
      @gear_links ||= (@hardware | @software)&.map do |ware|
        "[#{ware.slug}]: #{ware.url} \"#{ware.description}\""
      end.join("\n")
    end

    def scan_links
      @contents.scan(/\[([^\[\(\)]+)\]\[([a-z0-9\.\-]+)?\]/).each do |link|
        slug = (link[1] ? link[1] : link[0].downcase)

        %w[hardware software].each do |type|
          if (ware = @site.send(type)[slug])
            unless send(type).include?(ware)
              send(type) << ware.tap { |w| w.interviews << self }
            end
          end
        end
      end
    end

    def inspect
      super
    end
  end
end
