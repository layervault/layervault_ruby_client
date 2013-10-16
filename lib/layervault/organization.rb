require 'hashie'

module LayerVault
  class Organization < Hashie::Mash
    class << self
      def for( organization )
        resp = MultiJson.decode(LayerVault.client.organization( organization ))
        projects = resp.fetch('projects', {})
        resp.delete(:projects) if projects
        projects = build_projects(projects)
        instance = new(resp)
        instance.projects = build_projects(projects)
        instance
      end

      def build_projects(projects)
        projects.map { |p| LayerVault::Project.new(p) }
      end
    end
  end
end