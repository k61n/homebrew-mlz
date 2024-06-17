# frozen_string_literal: true

class PythonToml < Formula
  desc "A Python library for parsing and creating TOML"
  homepage "https://github.com/uiri/toml"
  url "https://github.com/uiri/toml.git",
      tag: "0.10.2"
  version "0.10.2"

  depends_on "python"

  def install
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    system "#{python_exe} setup.py build"
    system python_exe, *Language::Python.setup_install_args(prefix, python_exe)
  end

  test do
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    system python_exe, "-c", "import toml"
  end
end
