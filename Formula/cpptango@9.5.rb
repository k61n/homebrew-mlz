# frozen_string_literal: true

class CpptangoAT95 < Formula
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
      ENV['cppzmq_ROOT'] = `#{HOMEBREW_PREFIX}/bin/brew --prefix cppzmq`.strip
      ENV["JPEG_ROOT"] = `#{HOMEBREW_PREFIX}/bin/brew --prefix jpeg-turbo`.strip
      ENV["omniORB4_ROOT"] = `#{HOMEBREW_PREFIX}/bin/brew --prefix omniorb`.strip
      ENV["tangoidl_ROOT"] = `#{HOMEBREW_PREFIX}/bin/brew --prefix tangoidl`.strip
      ENV["ZeroMQ_ROOT"] = `#{HOMEBREW_PREFIX}/bin/brew --prefix zeromq`.strip
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
