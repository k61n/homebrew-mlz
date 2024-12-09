class PythonPackagingSupplement < Formula
  desc "Core utilities for Python packages"
  homepage "https://packaging.pypa.io/"
  url "https://files.pythonhosted.org/packages/d0/63/68dbb6eb2de9cb10ee4c9c14a0148804425e13c4fb20d61cce69f53106da/packaging-24.2.tar.gz"
  sha256 "c228a6dc5e932d346bc5739379109d49e8853dd8223571c7c5b55260edc0b97f"
  license any_of: ["Apache-2.0", "BSD-2-Clause"]

  depends_on "python"

  def install
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      # supplement brew formula for python3.9-3.11
      if python.gsub("python@3.", "").to_i >= 9 && python.gsub("python@3.", "").to_i < 12
        python_exe = "#{HOMEBREW_PREFIX}/bin/#{python.gsub("@", "")}"
        system python_exe, "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
      end
    end
  end

  test do
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      if python.gsub("python@3.", "").to_i >= 9 && python.gsub("python@3.", "").to_i < 12
        python_exe = "#{HOMEBREW_PREFIX}/bin/#{python.gsub("@", "")}"
        system python_exe, "-c", "import packaging"
      end
    end
  end
end