# frozen_string_literal: true

class NexusFormat < Formula
  desc "C++ data format library for neutron, x-ray, and muon experiments."
  homepage "https://www.nexusformat.org/"
  url "https://github.com/nexusformat/code.git",
      tag: "v4.4.3"
  version "4.4.3"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "hdf5"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    hdf5_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix hdf5`.strip
    mkdir "build" do
      system "#{HOMEBREW_PREFIX}/bin/cmake",
             "..",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DENABLE_HDF5=1",
             "-DHDF5_ROOT=#{hdf5_path}",
             "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
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
