require 'formula'

HOMEBREW_PT_VERSION='2.1.2'
class Pt < Formula
  homepage 'https://github.com/monochromegane/the_platinum_searcher'
  url "https://github.com/monochromegane/the_platinum_searcher/releases/download/v#{HOMEBREW_PT_VERSION}/pt_darwin_amd64.zip"
  sha1 '4418135b75fbe3b8e321f6a22d603d07882a96e2'

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
      system 'go', 'get', 'github.com/monochromegane/go-home'
      system 'go', 'get', 'github.com/monochromegane/conflag'
      system 'go', 'get', 'github.com/monochromegane/go-gitignore'
      system 'go', 'get', 'github.com/jessevdk/go-flags'
      system 'go', 'get', 'golang.org/x/text/transform'
      system 'go', 'get', 'golang.org/x/text/encoding/japanese'
      mkdir_p buildpath/'src/github.com/monochromegane'
      ln_s buildpath, buildpath/'src/github.com/monochromegane/the_platinum_searcher'
      system 'go', 'build', '-o', 'pt', 'cmd/pt/main.go'
    end
    bin.install 'pt'
  end
end
