# Homebrew formula for the prune CLI, the terminal companion to Prune.app.
class Prune < Formula
  desc "Find and clean reclaimable disk space on macOS from the terminal"
  homepage "https://prune.gh0styx.com"
  url "https://github.com/gh0styx/prune/archive/refs/tags/cli-v0.1.1.tar.gz"
  sha256 "2aaea515f5f04e02486d1e354e99e0b4d955f4012d8e51becabc8cd2d7021eb3"
  license "GPL-3.0-only"

  depends_on xcode: ["16.0", :build]
  depends_on macos: :ventura

  def install
    cd "cli" do
      system "swift", "build", "--disable-sandbox", "--configuration", "release"
      bin.install ".build/release/prune"
    end
  end

  test do
    assert_match "prune #{version}", shell_output("#{bin}/prune --version")
    # Dry run only: the test never removes anything.
    assert_match "node_modules", shell_output("#{bin}/prune purge --root #{testpath}")
  end
end
