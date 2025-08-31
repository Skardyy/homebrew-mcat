class Mcat < Formula
  desc "a powerfull extended cat command, to cat all the things you couldn't before"
  homepage "https://github.com/Skardyy/mcat"
  version "0.4.4"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Skardyy/mcat/releases/download/v0.4.4/mcat-aarch64-apple-darwin.tar.xz"
    sha256 "318115cad7290f000c1408ef9604da42d751d15600a952fe29ddcb3e578aa761"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.4/mcat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1a826e43231d661df971773124de96f84a5a6a264fbf910dad0541aa34f9acc8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.4/mcat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1717be3f120f93a4f2441778d3733e014b65b5c95f20191e26df96397ea053ce"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "mcat" if OS.mac? && Hardware::CPU.arm?
    bin.install "mcat" if OS.linux? && Hardware::CPU.arm?
    bin.install "mcat" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
