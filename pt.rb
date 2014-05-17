require 'formula'

class Pt < Formula
  homepage 'https://github.com/monochromegane/the_platinum_searcher'
  url 'https://github.com/monochromegane/the_platinum_searcher.git'

  depends_on 'go' => :build
  depends_on 'hg' => :build

  def install
    ENV['GOPATH'] = buildpath
    system 'go', 'get', './...'
    system 'go', 'build', '-o', 'pt'
    bin.install 'pt'
  end
end
