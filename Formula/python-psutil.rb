# frozen_string_literal: true

class PythonPsutil < Formula
  desc "Cross-platform lib for process and system monitoring in Python"
  homepage "https://github.com/giampaolo/psutil"
  url "https://github.com/giampaolo/psutil.git",
      tag: "release-7.0.0"
  version "7.0.0"

  depends_on "python"
  depends_on "python-setuptools"

  def install
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      # doesn't install with python3.9
      if python.gsub("python@3.", "").to_i > 9
        python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
        system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
      end
    end
  end

  test do
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      if python.gsub("python@3.", "").to_i > 9
        python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
        system python_exe, "-c", "import psutil"
      end
    end
  end
end
