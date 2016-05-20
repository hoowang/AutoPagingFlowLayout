Pod::Spec.new do |s|
  s.name = 'AutoPagingFlowLayout'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'an collectionView auto paging layout in Swift for iOS'
  s.homepage = 'https://github.com/hoowang/AutoPagingFlowLayout'
  s.authors = { 'hooge' => 'hoowang@126.com' }
  s.source = { :git => 'https://github.com/hoowang/AutoPagingFlowLayout.git', :tag => s.version }

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'AutoPagingFlowLayout/*.swift'
end