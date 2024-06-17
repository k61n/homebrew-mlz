# frozen_string_literal: true

class PythonNicosPyctl < Formula
  desc "nicos-pyctl"
  homepage "https://github.com/mlz-ictrl/nicos-pyctl/"
  url "https://github.com/mlz-ictrl/nicos-pyctl.git",
      tag: "v1.3.0"
  version "1.3.0"

  depends_on "python"

  def install
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
  end

  test do
    python_exe = "#{HOMEBREW_PREFIX}/bin/python3"
    system python_exe, "-c", "import nicospyctl"
  end
end
