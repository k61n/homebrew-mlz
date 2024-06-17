# frozen_string_literal: true

class Cpptango < Formula
  desc "Distributed Control System - C++ library"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/cppTango.git",
      tag: "9.5.0"
  version "9.5.0"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "cppzmq"
  depends_on "jpeg-turbo"
  depends_on "omniorb"
  depends_on "mlz/packages/tangoidl"
  depends_on "zeromq"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    mkdir "build" do
      cppzmq_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix cppzmq`.strip
      jpeg_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix jpeg-turbo`.strip
      omniorb_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix omniorb`.strip
      tangoidl_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix tangoidl`.strip
      zeromq_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix zeromq`.strip
      ENV["CC"] = "/usr/bin/clang"
      ENV["CXX"] = "/usr/bin/clang++"
      ENV['cppzmq_ROOT'] = cppzmq_root
      ENV["JPEG_ROOT"] = jpeg_root
      ENV["omniORB4_ROOT"] = omniorb_root
      ENV["tangoidl_ROOT"] = tangoidl_root
      ENV["ZeroMQ_ROOT"] = zeromq_root
      system "#{HOMEBREW_PREFIX}/bin/cmake", "..",
             "-DCMAKE_BUILD_TYPE=Release", "-DBUILD_TESTING=OFF",
             "-DTANGO_USE_LIBCPP=ON", "-DTANGO_USE_JPEG=ON",
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
