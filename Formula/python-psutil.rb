# frozen_string_literal: true

class PythonPsutil < Formula
  desc "Cross-platform lib for process and system monitoring in Python"
  homepage "https://github.com/giampaolo/psutil"
  url "https://github.com/giampaolo/psutil.git",
      tag: "release-5.9.8"
  version "5.9.8"

  depends_on "python"
  depends_on "python-setuptools"

  def install
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    system "#{python_exe} setup.py build"
    system python_exe, *Language::Python.setup_install_args(prefix, python_exe)
  end

  test do
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    system python_exe, "-c", "import psutil"
  end
end
