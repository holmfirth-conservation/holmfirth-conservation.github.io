module Jekyll
  class BuildingPage < Page
    def initialize(site, base, dir, building)
      @site = site
      @base = base
      @dir = dir
      @name = "#{building['uid']}.html"

      # Extract info from the filename
      self.process(@name)

      # Read YAML frontmatter and template and load into data structure
      self.read_yaml(File.join(base, '_layouts'), 'building.html')
      self.data['title'] = "Building #{building['uid']}"
      self.data['building'] = building

      self.data['body'] = building.values.join(" ") # For lunr search
    end
  end

  class BuildingPageGenerator < Generator
    safe true
    priority :highest
    def generate(site)
      dir = 'buildings'
      site.data['buildings'].each do |building|
        site.pages << BuildingPage.new(
          site, site.source, 'buildings', building)
      end
    end
  end

end
