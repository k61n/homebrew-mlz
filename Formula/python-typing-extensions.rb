# frozen_string_literal: true

class PythonTypingExtensions < Formula
  desc "Backported and Experimental Type Hints for Python 3.8+"
  homepage "https://github.com/python/typing_extensions"
  url "https://github.com/python/typing_extensions.git",
      tag: "4.13.2"
  version "4.13.2"

  depends_on "python"
  depends_on "python-setuptools"


  resource "any" do
    url "https://files.pythonhosted.org/packages/8b/54/b1ae86c0973cc6f0210b53d508ca3641fb6d0c56823f288d108bc7ab3cc8/typing_extensions-4.13.2-py3-none-any.whl"
    sha256 "a439e7c04b49fec3e5d3e2beaa21755cadbbdc391694e28ccdd36ca4a1408f8c"
  end


  def install
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
      system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
      resource("any").stage do
        wheel_file = Dir[Pathname.pwd/"typing_extensions*.whl"].first
        system python_exe, "-m", "pip", "install", *std_pip_args, wheel_file
      end
    end
  end

  test do
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
      system python_exe, "-c", "import typing_extensions"
    end
  end
end
