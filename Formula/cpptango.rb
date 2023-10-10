# frozen_string_literal: true

class Cpptango < Formula
  desc "Distributed Control System - C++ library"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/cppTango.git",
      tag: "9.5.0"
  version "9.5.0"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "subversion" => :build
  depends_on "cppzmq"
  depends_on "jpeg-turbo"
  depends_on "omniorb"
  depends_on "mlz/packages/tangoidl"
  depends_on "zeromq"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    mkdir "build" do
      cppzmq_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix cppzmq`.strip
      jpeg_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix jpeg-turbo`.strip
      omniorb_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix omniorb`.strip
      tangoidl_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix tangoidl`.strip
      zeromq_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix zeromq`.strip
      system "CC=/usr/bin/clang CXX=/usr/bin/clang++ " +
             "#{HOMEBREW_PREFIX}/bin/cmake .. " +
             "-DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF " +
             "-DTANGO_USE_LIBCPP=ON -DTANGO_USE_JPEG=ON " +
             "-Dcppzmq_ROOT=#{cppzmq_path} " +
             "-DJPEG_ROOT=#{jpeg_path} " +
             "-DomniORB4_ROOT=#{omniorb_path} " +
             "-Dtangoidl_ROOT=#{tangoidl_path} " +
             "-DZeroMQ_ROOT=#{zeromq_path} " +
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
