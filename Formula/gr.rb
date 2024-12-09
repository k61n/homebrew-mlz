# frozen_string_literal: true

class Gr < Formula
  desc "GR - a universal framework for visualization applications"
  homepage "https://gr-framework.org/"
  url "https://github.com/sciapp/gr.git",
      tag: "v0.73.9"
  version "0.73.9"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "cairo"
  depends_on "ghostscript"
  depends_on "ffmpeg"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "glfw"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "libx11"
  depends_on "pixman"
  depends_on "qhull"
  depends_on "qt@6"
  depends_on "vulkan-headers"
  depends_on "zeromq"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    cairo_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix cairo`.strip
    ffmpeg_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix ffmpeg`.strip
    fontconfig_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix fontconfig`.strip
    freetype_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix freetype`.strip
    ghostscript_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix ghostscript`.strip
    glfw_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix glfw`.strip
    jpeg_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix jpeg`.strip
    libpng_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix libpng`.strip
    libtiff_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix libtiff`.strip
    libx11_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix libx11`.strip
    pixman_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix pixman`.strip
    qhull_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix qhull`.strip
    qt6_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix qt@6`.strip
    vulkan_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix vulkan-headers`.strip
    zeromq_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix zeromq`.strip
    mkdir "build" do
      system "CC=/usr/bin/clang CXX=/usr/bin/clang++ " +
               "#{HOMEBREW_PREFIX}/bin/cmake .. -DCMAKE_BUILD_TYPE=Release " +
               "-DCMAKE_PREFIX_PATH=#{qt6_root} " +
               "-DCairo_ROOT=#{cairo_root} " +
               "-DFfmpeg_ROOT=#{ffmpeg_root} " +
               "-DFontconfig_ROOT=#{fontconfig_root} " +
               "-DFreetype_ROOT=#{freetype_root} " +
               "-DGs_ROOT=#{ghostscript_root} " +
               "-Dglfw3_ROOT=#{glfw_root} " +
               "-DJpeg_ROOT=#{jpeg_root} " +
               "-DLibpng_ROOT=#{libpng_root} " +
               "-DTiff_ROOT=#{libtiff_root} " +
               "-DX11_ROOT=#{libx11_root} " +
               "-DPixman_ROOT=#{pixman_root} " +
               "-DQhull_ROOT=#{qhull_root} " +
               "-DVulkan_INCLUDE_DIR=#{vulkan_root} " +
               "-DZeroMQ_ROOT=#{zeromq_root} " +
               "-DCMAKE_INSTALL_PREFIX=#{buildpath}/install"
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--build", ".", "--parallel", cores.to_s
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--install", "."
    end
    prefix.install Dir["install/*"]
  end

  test do
    # Test commands to verify that your software is working
  end
end
