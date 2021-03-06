Pod::Spec.new do |s|
  s.name             = 'BEENavigationBar'
  s.version          = '1.0.0'
  s.summary          = 'A short description of BEENavigationBar.'
  s.homepage         = 'https://github.com/liuxc123/BEENavigationBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/BEENavigationBar.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.frameworks = 'UIKit', 'Foundation'

  s.source_files = 'BEENavigationBar/Classes/**/*'
  s.resources = 'BEENavigationBar/Assets/**/*'
end
