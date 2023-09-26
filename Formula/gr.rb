# frozen_string_literal: true

class Gr < Formula
  desc "GR - a universal framework for visualization applications"
  homepage "https://gr-framework.org/"
  url "https://github.com/sciapp/gr.git",
      tag: "v0.72.10"
  version "0.72.10"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "cairo"
  depends_on "ffmpeg"
  depends_on "freetype"
  depends_on "glfw"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libx11"
  depends_on "libtiff"
  depends_on "pixman"
  depends_on "qhull"
  depends_on "qt@5"
  depends_on "qt@6"
  depends_on "zeromq"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    cmake = `#{HOMEBREW_PREFIX}/bin/brew --prefix cmake`.strip
    mkdir "build" do
      qt5_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix qt@5`.strip
      qt6_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix qt@6`.strip
      system "CC=/usr/bin/clang CXX=/usr/bin/clang++ " +
               "#{cmake}/bin/cmake .. -DCMAKE_BUILD_TYPE=Release " +
               "-DCMAKE_PREFIX_PATH='#{qt5_path};#{qt6_path}' " +
               "-DCMAKE_INSTALL_PREFIX=#{buildpath}/install"
      system "cmake", "--build", ".", "--parallel", cores.to_s
      system "cmake", "--install", "."
    end
    prefix.install Dir["install/*"]
  end

  test do
    # Test commands to verify that your software is working
  end
end
