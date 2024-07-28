# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FoodPicker' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks! # :linkage => :static

  pod 'AMapSearch-NO-IDFA', '9.3.0'
  pod 'AMapFoundation-NO-IDFA', '1.7.0'
  # pod 'Kingfisher',  '7.6.1'

  # Pods for FoodPicker

end

# for silicon chip mac simulator
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "$(inherited) arm64"
  end
end
