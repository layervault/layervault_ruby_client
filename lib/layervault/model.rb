require 'hashie'

module LayerVault
  class Model < Hashie::Mash
    CLASS_MAP = {
      projects: 'LayerVault::Project',
      folders: 'LayerVault::Folder',
      files: 'LayerVault::File',
      revisions: 'LayerVault::Revision'
    }

    class << self
      def build_associations(hash, *associations)
        mapping = {}

        associations.each do |association|
          mapping[association] = hash.fetch(association.to_s, {})
          hash.delete(association) if mapping[association]
        end

        instance = new(hash)

        associations.each do |association|
          klass = Kernel.const_get(CLASS_MAP[association])
          objs = mapping[association].map { |p| klass.new(p) }
          instance[association.to_s] = objs
        end

        instance
      end
    end

    def set_context(context_arguments={})
      self.context = {}
      context_arguments.each do |argument, value|
        self.context[argument] = value
      end
      self
    end
  end
end