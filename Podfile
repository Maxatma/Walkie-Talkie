
use_frameworks!
inhibit_all_warnings!
platform :ios, '13.2'

def ui
  pod 'PIPKit'
end

def main
  pod 'GoogleWebRTC'
  pod 'Bond', '6.10.2'
  pod 'ReactiveKit', '3.9.7'
  pod 'SnapKit'
  pod 'IQKeyboardManagerSwift'
end

def firebase
  pod 'Firebase/Firestore'
end


target 'Walkie-Talkie' do
  main
  ui
  firebase
end

