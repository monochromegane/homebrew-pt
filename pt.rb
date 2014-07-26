require 'formula'

HOMEBREW_PT_VERSION='1.7.1'
class Pt < Formula
  homepage 'https://github.com/monochromegane/the_platinum_searcher'
  url "https://github.com/monochromegane/the_platinum_searcher/releases/download/v#{HOMEBREW_PT_VERSION}/pt_darwin_amd64.zip"
  sha1 '00844c339ca864bdae77fe4481a103456760181e'

  version HOMEBREW_PT_VERSION
  head 'https://github.com/monochromegane/the_platinum_searcher.git', :branch => 'master'

  if build.head?
    depends_on 'go' => :build
    depends_on 'hg' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath
      system 'go', 'get', 'github.com/shiena/ansicolor'
      system 'go', 'get', 'github.com/monochromegane/terminal'
      system 'go', 'get', 'github.com/jessevdk/go-flags'
      system 'go', 'get', 'code.google.com/p/go.text/transform'
      mkdir_p buildpath/'src/github.com/monochromegane'
      ln_s buildpath, buildpath/'src/github.com/monochromegane/the_platinum_searcher'
      system 'go', 'build', '-o', 'pt', 'cmd/pt/main.go'
    end
    bin.install 'pt'
  end
end
