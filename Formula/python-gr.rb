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
  depends_on "python@3.12"

  def install
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3.12"
    gr_root = `#{HOMEBREW_PREFIX}/bin/brew --prefix gr`.strip
    ENV['GRLIB'] = "#{gr_root}/lib"
    system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
  end

  test do
    # Test commands to verify that your software is working
  end
end
