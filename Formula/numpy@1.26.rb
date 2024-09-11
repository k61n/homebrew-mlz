class NumpyAT126 < Formula
  desc "Package for scientific computing with Python"
  homepage "https://www.numpy.org/"
  license "BSD-3-Clause"
  url "https://github.com/numpy/numpy.git",
      tag: "v1.26.4"
  version "1.26.4"

  depends_on "openblas"
  depends_on "python"

  resource "arm64" do
    url "https://files.pythonhosted.org/packages/75/5b/ca6c8bd14007e5ca171c7c03102d17b4f4e0ceb53957e8c44343a9546dcc/numpy-1.26.4-cp312-cp312-macosx_11_0_arm64.whl"
    sha256 "03a8c78d01d9781b28a6989f6fa1bb2c4f2d51201cf99d3dd875df6fbd96b23b"
  end

  resource "x86_64" do
    url "https://files.pythonhosted.org/packages/95/12/8f2020a8e8b8383ac0177dc9570aad031a3beb12e38847f7129bacd96228/numpy-1.26.4-cp312-cp312-macosx_10_9_x86_64.whl"
    sha256 "b3ce300f3644fb06443ee2222c2201dd3a89ea6040541412b8fa189341847218"
  end

  def install
    python3 = "#{HOMEBREW_PREFIX}/bin/python3"
    arch = Hardware::CPU.arch.to_s
    resource(arch).stage do
      wheel_file = Dir[Pathname.pwd/"numpy*#{arch}.whl"].first
      system python3, "-m", "pip", "install", *std_pip_args, wheel_file
    end
  end

  test do
    pythons.each do |python|
      python3 = "#{HOMEBREW_PREFIX}/bin/python3"
      system python3, "-c", <<~EOS
        import numpy as np
        t = np.ones((3,3), int)
        assert t.sum() == 9
        assert np.dot(t, t).sum() == 27
      EOS
    end
  end
end