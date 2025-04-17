# frozen_string_literal: true

class PythonNicosPyctl < Formula
  desc "nicos-pyctl"
  homepage "https://github.com/mlz-ictrl/nicos-pyctl/"
  url "https://github.com/mlz-ictrl/nicos-pyctl.git",
      tag: "v1.3.0"
  version "1.3.0"

  depends_on "python"

  def install
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
      system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
    end
  end

  test do
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
      system python_exe, "-c", "import nicospyctl"
    end
  end
end
