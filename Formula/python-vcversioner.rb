# frozen_string_literal: true

class PythonVcversioner < Formula
  desc "take version numbers from version control"
  homepage "https://github.com/habnabit/vcversioner"
  url "https://github.com/habnabit/vcversioner.git",
      tag: "2.16.0.0"
  version "2.16.0.0"

  depends_on "python@3.12"
  depends_on "python-setuptools"

  def install
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3.12"
    system "#{python_exe} setup.py build"
    system python_exe, *Language::Python.setup_install_args(prefix, python_exe)
  end

  test do
    # Test commands to verify that your software is working
  end
end
