Pod::Spec.new do |s|
  s.name             = 'BEENavigationBar'
  s.version          = '1.0.0'
  s.summary          = 'A short description of BEENavigationBar.'
  s.homepage         = 'https://github.com/liuxc123/BEENavigationBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/BEENavigationBar.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'BEENavigationBar/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.resource_bundles = {
    'BEENavigationBar' => ['BEENavigationBar/Assets/*.png']
  }
end
