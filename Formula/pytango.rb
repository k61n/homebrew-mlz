# frozen_string_literal: true

class Pytango < Formula
  desc "Python module for cppTango C++ libraries"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/pytango.git",
      tag: "v10.1.3"
  version "10.1.3"

  depends_on "git" => :build
  depends_on "numpy"
  depends_on "python@3.14"
  depends_on "python-packaging"
  depends_on "mlz/packages/python-typing-extensions"

  def install
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      py_minor = python.gsub("python@3.", "").to_i
      next unless py_minor >= 10

      python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
      system python_exe, "-m", "pip", "install", *std_pip_args,
             "--only-binary=:all:", "pytango==#{version}"
    end
  end

  test do
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      py_minor = python.gsub("python@3.", "").to_i
      next unless py_minor >= 10

      python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
      system python_exe, "-c", "from tango import DeviceProxy"
    end
  end
end
