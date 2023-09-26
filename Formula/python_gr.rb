# frozen_string_literal: true

class Python_gr < Formula
  desc "GR - a universal framework for visualization applications"
  homepage "https://gr-framework.org/"
  url "https://github.com/sciapp/python-gr.git",
      tag: "v1.23.2"
  version "1.23.2"

  depends_on "k61n/mlz/gr"
  depends_on "numpy"
  depends_on "python"

  def install
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    gr_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix gr`.strip
    system "GR_VERSION=0.72.10 " +
             "GRLIB=#{gr_root} " +
             "#{python_exe} setup.py build"
    system python_exe, *Language::Python.setup_install_args(prefix, python_exe)
  end

  test do
    # Test commands to verify that your software is working
  end
end
