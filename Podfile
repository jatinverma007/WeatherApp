source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0’

target 'WeatherBitcoinSample' do
   use_frameworks!
   pod 'Alamofire', '~> 4.0'
   pod 'ReachabilitySwift', '~> 3'
   pod 'SwiftyJSON', :git => 'https://github.com/SwiftyJSON/SwiftyJSON'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = ‘4.0’
        end
    end
end
