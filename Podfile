# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def shared_pods
  use_frameworks!
  pod 'Alamofire', '~> 4.8.2'
  pod 'Kingfisher', '~> 5.0'
  pod 'ReachabilitySwift'
end

target 'PropertyListExercise' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  shared_pods
  # Pods for PropertyListExercise

  target 'PropertyListExerciseUITests' do
    inherit! :search_paths
    shared_pods
    # Pods for testing
  end

end
