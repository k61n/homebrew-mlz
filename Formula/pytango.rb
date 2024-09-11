# frozen_string_literal: true

class Pytango < Formula
  desc "Python module for cppTango C++ libraries"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/pytango.git",
      tag: "v9.5.1"
  version "9.5.1"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "python"
  depends_on "python-packaging"
  depends_on "mlz/packages/cpptango"
  depends_on "mlz/packages/numpy@1.26"

  def install
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    boost_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix boost`.strip
    boost_python_deps = `#{HOMEBREW_PREFIX}/bin/brew deps boost-python3`.strip
    cppzmq_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix cppzmq`.strip
    omniorb_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix omniorb`.strip
    tango_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix cpptango`.strip
    ENV['BOOST_ROOT'] = boost_root
    ENV['BOOST_PYTHON_SUFFIX'] = boost_python_deps.match(/python@(\d+\.\d+)/)[1].gsub(".", "")
    ENV['CPPZMQ_ROOT'] = cppzmq_root
    ENV['omniORB4_ROOT'] = omniorb_root
    ENV['Tango_ROOT'] = tango_root
    system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
  end

  test do
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    system python_exe, "-c", "from tango import DeviceProxy"
  end
end
