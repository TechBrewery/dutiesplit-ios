platform :ios, '10.0'
inhibit_all_warnings!
install! 'cocoapods', integrate_targets: false

def pods

end

target 'DutieSplit' do
  pods
end

target 'DutieSplitTests' do
  pods
end

plugin 'cocoapods-keys', {
  project: 'DutieSplit',
  keys: [
    'Staging_hockeyAppIdentifier',
    'Beta_hockeyAppIdentifier',
  ]
}
