# frozen_string_literal: true

class PythonToml < Formula
  desc "A Python library for parsing and creating TOML"
  homepage "https://github.com/uiri/toml"
  url "https://github.com/uiri/toml.git",
      tag: "0.10.2"
  version "0.10.2"

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
      system python_exe, "-c", "import toml"
    end
  end
end
