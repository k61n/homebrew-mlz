# frozen_string_literal: true

class Hdf4 < Formula
  desc "Multi-object file format library."
  homepage "https://www.hdfgroup.org/solutions/hdf4/"
  url "https://github.com/HDFGroup/hdf4.git",
      tag: "hdf-4_2_16-2"
  version "4.2.16"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "jpeg-turbo"
  depends_on "zlib"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    mkdir "build" do
      system "CC=/usr/bin/clang CXX=/usr/bin/clang++ " +
               "cmake .. -DCMAKE_BUILD_TYPE=Release " +
               "-DCMAKE_INSTALL_PREFIX=#{buildpath}/install"
      system "cmake", "--build", ".", "--parallel", cores.to_s
      system "cmake", "--install", "."
      system "find #{buildpath}/install -name '*.a' -delete"
    end
    prefix.install Dir["install/*"]
  end

  test do
    # Test commands to verify that your software is working
  end
end
