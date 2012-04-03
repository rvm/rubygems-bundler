module Gem
  post_install do |inst|
    RubyGemsBundlerInstaller.bundler_generate_bin(inst)
  end
end