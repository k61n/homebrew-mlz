# frozen_string_literal: true

class PythonGr < Formula
  desc "GR - a universal framework for visualization applications"
  homepage "https://gr-framework.org/"
  url "https://github.com/sciapp/python-gr.git",
      tag: "v1.24.0"
  version "1.24.0"

  depends_on "mlz/packages/gr"
  depends_on "mlz/packages/python-vcversioner"
  depends_on "numpy"
  depends_on "python"

  def install
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    gr_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix gr`.strip
    gr_version = `#{HOMEBREW_PREFIX}/bin/brew list gr --versions`.strip
    gr_version = gr_version.sub(/^gr\s+/, '')
    system "GR_VERSION=#{gr_version} " +
             "GRLIB=#{gr_root} " +
             "#{python_exe} setup.py build"
    system python_exe, *Language::Python.setup_install_args(prefix, python_exe)
  end

  test do
    # Test commands to verify that your software is working
  end
end
