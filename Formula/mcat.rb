class Mcat < Formula
  desc "Terminal image, video, directory, and Markdown viewer"
  homepage "https://github.com/Skardyy/mcat"
  version "0.4.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.4/mcat-aarch64-apple-darwin.tar.xz"
      sha256 "904e7dcc4bf526e2809d0b17d0b75fd84a49bb75ec29e1ec01c7649ec1a05602"
    end
    if Hardware::CPU.intel?
      # Intel Mac builds are not available for this release
      odie "Intel Mac is not supported in this release. Please use an ARM Mac or build from source."
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.4/mcat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6e18503c0a6f93b9543396b2aa8e74b57f2baaf598d9f235bf4c580405ceda03"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Skardyy/mcat/releases/download/v0.4.4/mcat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2af28f2f8eadd843d04dbedce19c10cd8f503e0e615586c42e40fd38cffee7e8"
    end
  end

  def install
    bin.install "mcat"
  end

  test do
    system "#{bin}/mcat", "--version"
  end
end
