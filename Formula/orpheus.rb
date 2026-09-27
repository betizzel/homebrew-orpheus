class Orpheus < Formula
  desc "Terminal music player with album art, visualizer, and remote playback over SSH"
  homepage "https://github.com/betizzel/Orpheus"
  url "https://github.com/betizzel/Orpheus/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "82ccefff9fcf876ae71c48eaf637a50d13078ccd8f4f203fab7136d6b4387c7b"
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "ffmpeg"
  depends_on "lua"
  depends_on "ncurses"
  depends_on "taglib"

  def install
    system "cmake", "-S", ".", "-B", "build", "-DENABLE_FFMPEG=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    doc.install "config.lua" => "config.lua.example"
  end

  test do
    assert_match "terminal music player", shell_output("#{bin}/orpheus --help 2>&1")
    assert_match "remote library server", shell_output("#{bin}/orpheusd --help 2>&1")
  end
end
