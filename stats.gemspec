Gem::Specification.new do |s|
  s.name        = 'stats'
  s.version     = '0.0a1'
  s.date        = '2018-10-28'
  s.summary     = 'stats made easy'
  s.description = 'stats made easy'
  s.authors     = ['Wes Young']
  s.email       = 'wes@barely3am.com'
  s.files       = %w(lib/stats.rb)
  s.homepage    =
      'http://github.com/wesyoung/stats-rb'
  s.license       = 'MPL2'

  %w(percentage descriptive_statistics levenshtein).each do |d|
    s.add_runtime_dependency d
  end
end
