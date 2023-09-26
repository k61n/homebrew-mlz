# frozen_string_literal: true

class Nexus < Formula
  desc "Data format library for neutron, x-ray, and muon experiments."
  homepage "https://github.com/nexusformat/code/"
  url "https://github.com/nexusformat/code.git",
      tag: "v4.4.3"
  version "4.4.3"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "k61n/hdf4/hdf4"
  depends_on "hdf5"
  depends_on "jpeg"
  depends_on "zlib"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    mkdir "build" do
      hdf4_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix hdf4`.strip
      hdf5_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix hdf5`.strip
      system "CC=/usr/bin/clang CXX=/usr/bin/clang++ " +
               "cmake .. -DCMAKE_BUILD_TYPE=Release " +
               "-DENABLE_HDF4=1 -DHDF4_ROOT=#{hdf4_path} " +
               "-DENABLE_HDF5=1 -DHDF5_ROOT=#{hdf5_path} " +
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
