require 'hashie'

module LayerVault
  class Model < Hashie::Mash
    CLASS_MAP = {
      projects: 'LayerVault::Project'
    }

    private

    def build_association(resp, *associations)
      mapping = {}

      associations.each do |association|
        mapping[association] = resp.fetch(association.to_s, {})
        resp.delete(association) if mapping[association]
      end

      instance = new(resp)

      associations.each do |association|
        klass = Kernel.const_get(CLASS_MAP[association])
        objs = mapping[association].map { |p| klass.new(p) }
        instance[association.to_s] = objs
      end

      instance
    end
  end
end