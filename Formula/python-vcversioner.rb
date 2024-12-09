# frozen_string_literal: true

class PythonVcversioner < Formula
  desc "take version numbers from version control"
  homepage "https://github.com/habnabit/vcversioner"
  url "https://github.com/habnabit/vcversioner.git",
      tag: "2.16.0.0"
  version "2.16.0.0"

  depends_on "python"
  depends_on "python-setuptools"

  def install
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      python_exe = "#{HOMEBREW_PREFIX}/bin/#{python.gsub("@", "")}"
      system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
    end
  end

  test do
    # Test commands to verify that your software is working
  end
end
