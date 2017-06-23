
Pod::Spec.new do |s|

  s.name         = "FLTableComponent"
  s.version      = "2.1.0"
  s.summary      = "A component for tableView and collectionView"

  s.description  = <<-DESC
A component for tableView and collectionView, which can greatly reduce your controller codes, also, you can set header or footer more easily
                   DESC

  s.homepage     = "https://github.com/gitkong/FLTableViewComponent"
  s.license	 = 'MIT'
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  s.author             = { "gitKong" => "13751855378@163.com" }

  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/gitkong/FLTableViewComponent.git", :tag => "#{s.version}" }

  s.source_files  = "FLTableComponent/**/*"

  s.requires_arc = true

end
