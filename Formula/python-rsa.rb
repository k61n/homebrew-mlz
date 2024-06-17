# frozen_string_literal: true

class PythonRsa < Formula
  desc "Pure Python RSA implementation"
  homepage "https://stuvel.eu/software/rsa/"
  url "https://github.com/sybrenstuvel/python-rsa.git",
      tag: "version-4.9"
  version "4.9"

  depends_on "python"

  def install
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
  end

  test do
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    system python_exe, "-c", "import rsa"
  end
end
