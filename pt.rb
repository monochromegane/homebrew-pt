require 'formula'

HOMEBREW_PT_VERSION='1.6.1'
class Pt < Formula
  homepage 'https://github.com/monochromegane/the_platinum_searcher'
  url 'https://github.com/monochromegane/the_platinum_searcher.git', :tag => "v#{HOMEBREW_PT_VERSION}" 
  version HOMEBREW_PT_VERSION

  depends_on 'go' => :build
  depends_on 'hg' => :build

  def install
    ENV['GOPATH'] = buildpath
    system 'go', 'get', 'github.com/shiena/ansicolor'
    system 'go', 'get', 'github.com/monochromegane/terminal'
    system 'go', 'get', 'github.com/jessevdk/go-flags'
    system 'go', 'get', 'code.google.com/p/go.text/transform'
    system 'go', 'get', 'github.com/monochromegane/the_platinum_searcher/search'
    system 'go', 'build', '-o', 'pt'
    bin.install 'pt'
  end
end
