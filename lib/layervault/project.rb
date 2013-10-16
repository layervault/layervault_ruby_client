require 'hashie'
require 'layervault/file'

module LayerVault
  class Project < Hashie::Mash
    include Hashie::Extensions::Coercion
    include Hashie::Extensions::DeepMerge
    coerce_value :files, LayerVault::File
  end
end