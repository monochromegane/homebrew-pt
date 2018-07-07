require 'formula'

HOMEBREW_PT_VERSION='2.1.6'
class Pt < Formula
  homepage 'https://github.com/monochromegane/the_platinum_searcher'
  url "https://github.com/monochromegane/the_platinum_searcher/releases/download/v#{HOMEBREW_PT_VERSION}/pt_darwin_amd64.zip"
  sha256 'bd13aca0a762311c93f64c3c8256e04c6cf79faf8e6bb72c2d54deb4f874ac51'

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
