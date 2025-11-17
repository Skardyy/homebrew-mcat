class Mcat < Formula
  desc "a powerfull extended cat command, to cat all the things you couldn't before"
  homepage "https://github.com/Skardyy/mcat"
  version "0.4.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.6/mcat-aarch64-apple-darwin.tar.xz"
      sha256 "c54683119f0d9089f00aad98a07b36b0078bc46e645bc597b2d0f9e4cc43c5a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.6/mcat-x86_64-apple-darwin.tar.xz"
      sha256 "7c32c6eb9194f07aa101e909dcbcc6a1c849ffa10adf8436e7bc31e50f01438f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.6/mcat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7e0ad88279e7c7baf1ce2997ff270daac25081fdd89e14fb78d0d77f11b56190"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.6/mcat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a572b5f2d790634840755ed3d876aa71711bb94ee2a268298e09c701495edd14"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
    bin.install "mcat" if OS.mac? && Hardware::CPU.intel?
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
