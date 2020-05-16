
use_frameworks!
inhibit_all_warnings!
platform :ios, '13.2'

def ui
  pod 'PIPKit'
  pod 'IQKeyboardManagerSwift'
  pod 'IHKeyboardAvoiding'
  pod 'SnapKit'
end

def main
  pod 'GoogleWebRTC'
  pod 'Bond', '6.10.2'
  pod 'ReactiveKit'
  pod 'SwiftyUserDefaults'
end

def firebase
  pod 'Firebase/Firestore'
end


target 'Walkie-Talkie' do
  main
  ui
  firebase
end

