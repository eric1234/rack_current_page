Gem::Specification.new do |s|

  s.name        = "rack_current_page"
  s.version     = '0.0.2'
  s.authors     = ['Eric Anderson']
  s.email       = ['eric@pixelwareinc.com']

  s.add_dependency 'rack'
  s.add_dependency 'rack_replace'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'debugger'

  s.files = Dir['lib/**/*.rb']
  s.extra_rdoc_files << 'README.rdoc'
  s.rdoc_options << '--main' << 'README.rdoc'

  s.summary     = 'All links to the current page will have class: current'
  s.description = <<DESCRIPTION
Any link to the current page will have the class "current" (or whatever
class name you designate). This allows for easy styling without having
the logic encoded multiple places throughout your templates.
DESCRIPTION

end
