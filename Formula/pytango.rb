# frozen_string_literal: true

class Pytango < Formula
  desc "Python module for cppTango C++ libraries"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/pytango.git",
      tag: "v10.0.2"
  version "10.0.2"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "ninja" => :build
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "numpy"
  depends_on "python@3.13"
  depends_on "mlz/packages/cpptango"

  def install
    python_exe = "#{HOMEBREW_PREFIX}/opt/python@3.13/bin/python3.13"
    ENV['BOOST_ROOT'] = `#{HOMEBREW_PREFIX}/bin/brew --prefix boost`.strip
    ENV['BOOST_PYTHON_SUFFIX'] = `#{HOMEBREW_PREFIX}/bin/brew deps boost-python3`.strip.match(/python@(\d+\.\d+)/)[1].gsub(".", "")
    ENV['CPPZMQ_ROOT'] = `#{HOMEBREW_PREFIX}/bin/brew --prefix cppzmq`.strip
    ENV['omniORB4_ROOT'] = `#{HOMEBREW_PREFIX}/bin/brew --prefix omniorb`.strip
    ENV['Tango_ROOT'] = `#{HOMEBREW_PREFIX}/bin/brew --prefix cpptango`.strip
    system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
  end

  test do
    python_exe = "#{HOMEBREW_PREFIX}/opt/python@3.13/bin/python3.13"
    system python_exe, "-c", "from tango import DeviceProxy"
  end
end
