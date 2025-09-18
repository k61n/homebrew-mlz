# frozen_string_literal: true

class Cpptango < Formula
  desc "Distributed Control System - C++ library"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/cppTango.git",
      tag: "10.1.1"
  version "10.1.1"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "cppzmq"
  depends_on "jpeg-turbo"
  depends_on "omniorb"
  depends_on "mlz/packages/tangoidl"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    repo_path = `#{HOMEBREW_PREFIX}/bin/brew --repository mlz/packages`.strip
    system "#{HOMEBREW_PREFIX}/bin/git apply #{repo_path}/patches/cpptango"
    mkdir "build" do
      ENV['cppzmq_ROOT'] = `#{HOMEBREW_PREFIX}/bin/brew --prefix cppzmq`.strip
      ENV["JPEG_ROOT"] = `#{HOMEBREW_PREFIX}/bin/brew --prefix jpeg-turbo`.strip
      ENV["omniORB4_ROOT"] = `#{HOMEBREW_PREFIX}/bin/brew --prefix omniorb`.strip
      ENV["tangoidl_ROOT"] = `#{HOMEBREW_PREFIX}/bin/brew --prefix tangoidl`.strip
      system "#{HOMEBREW_PREFIX}/bin/cmake", "..",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DBUILD_TESTING=OFF",
             "-DTANGO_USE_LIBCPP=ON",
             "-DTANGO_USE_TELEMETRY=OFF",
             "-DTANGO_USE_JPEG=ON",
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
