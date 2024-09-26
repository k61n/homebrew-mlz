# frozen_string_literal: true

class Tangoidl < Formula
  desc "Tango CORBA IDL file."
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/tango-idl.git",
      tag: "6.0.2"
  version "6.0.2"

  depends_on "cmake" => :build
  depends_on "git" => :build

  def install
    mkdir "build" do
      system "#{HOMEBREW_PREFIX}/bin/cmake .. -DCMAKE_INSTALL_PREFIX=#{buildpath}/install"
      system "#{HOMEBREW_PREFIX}/bin/cmake --install ."
    end
    prefix.install Dir["install/*"]
  end

  test do
    # Test commands to verify that your software is working
  end
end
