# frozen_string_literal: true

class Pytango < Formula
  desc "Python module for cppTango C++ libraries"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/pytango.git",
      tag: "v9.4.2"
  version "9.4.2"

  depends_on "git" => :build
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "mlz/packages/cpptango"
  depends_on "numpy"
  depends_on "python"

  def install
    repo_path = `#{HOMEBREW_PREFIX}/bin/brew --repository mlz/packages`.strip
    system "#{HOMEBREW_PREFIX}/bin/git apply #{repo_path}/patches/pytango"
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    boost_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix boost`.strip
    boos_python_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix boost-python3`.strip
    cppzmq_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix cppzmq`.strip
    omni_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix omniorb`.strip
    tango_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix cpptango`.strip
    zmq_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix zeromq`.strip
    system "BOOST_ROOT=#{boost_root} BOOST_PYTHON_ROOT=#{boos_python_root} " +
             "BOOST_PYTHON_LIB=boost_python311 " +
             "CPPZMQ_ROOT=#{cppzmq_root} OMNI_ROOT=#{omni_root} " +
             "PKG_CONFIG_PATH=#{tango_root}/lib/pkgconfig TANGO_ROOT=#{tango_root} " +
             "ZMQ_ROOT=#{zmq_root} #{python_exe} setup.py build"
    system python_exe, *Language::Python.setup_install_args(prefix, python_exe)
  end

  test do
    # Test commands to verify that your software is working
  end
end
