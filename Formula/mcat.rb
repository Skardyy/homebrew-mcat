class Mcat < Formula
  desc "a powerfull extended cat command, to cat all the things you couldn't before"
  homepage "https://github.com/Skardyy/mcat"
  version "0.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.5/mcat-aarch64-apple-darwin.tar.xz"
      sha256 "1efafd5417eef6d4157d2373b42f2a92c9578bcc83cf2c9c277dbabe52970557"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.5/mcat-x86_64-apple-darwin.tar.xz"
      sha256 "891927bcee69ff89c03e4e72255747513cbcc55144689f746a92c6fccd15f398"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.5/mcat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "79c09dcd0ad34d48fc36742546d0d3dcb1770c25644268d642f94f9fede588ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.5/mcat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "70ca0166830ae0a41fb08de67e05722e037199cd691f9d3c0fa44f80eb51e088"
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
