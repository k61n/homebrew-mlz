# frozen_string_literal: true

class PythonGr < Formula
  desc "GR - a universal framework for visualization applications"
  homepage "https://gr-framework.org/"
  url "https://github.com/sciapp/python-gr.git",
      tag: "v1.25.0"
  version "1.25.0"

  depends_on "mlz/packages/gr"
  depends_on "mlz/packages/python-vcversioner"
  depends_on "numpy"
  depends_on "python"

  def install
    ENV['GRLIB'] = `#{HOMEBREW_PREFIX}/bin/brew --prefix gr`.strip
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      # can't install for python3.9
      if python.gsub("python@3.", "").to_i > 9
        python_exe = "#{HOMEBREW_PREFIX}/bin/#{python.gsub("@", "")}"
        system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
      end
    end
  end

  test do
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      # no numpy for pythons < 3.12
      if python.gsub("python@3.", "").to_i > 11
        python_exe = "#{HOMEBREW_PREFIX}/bin/#{python.gsub("@", "")}"
        system python_exe, "-c", "from gr import pygr"
      end
    end
  end
end
