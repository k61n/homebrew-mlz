class NumpyAT126 < Formula
  desc "Package for scientific computing with Python"
  homepage "https://www.numpy.org/"
  license "BSD-3-Clause"
  url "https://github.com/numpy/numpy.git",
      tag: "v1.26.4"
  version "1.26.4"

  depends_on "openblas"
  depends_on "python"

  resource "cp39_arm64" do
    url "https://files.pythonhosted.org/packages/ae/8c/ab03a7c25741f9ebc92684a20125fbc9fc1b8e1e700beb9197d750fdff88/numpy-1.26.4-cp39-cp39-macosx_11_0_arm64.whl"
    sha256 "52b8b60467cd7dd1e9ed082188b4e6bb35aa5cdd01777621a1658910745b90be"
  end

  resource "cp310_arm64" do
    url "https://files.pythonhosted.org/packages/20/f7/b24208eba89f9d1b58c1668bc6c8c4fd472b20c45573cb767f59d49fb0f6/numpy-1.26.4-cp310-cp310-macosx_11_0_arm64.whl"
    sha256 "2e4ee3380d6de9c9ec04745830fd9e2eccb3e6cf790d39d7b98ffd19b0dd754a"
  end

  resource "cp311_arm64" do
    url "https://files.pythonhosted.org/packages/1a/2e/151484f49fd03944c4a3ad9c418ed193cfd02724e138ac8a9505d056c582/numpy-1.26.4-cp311-cp311-macosx_11_0_arm64.whl"
    sha256 "edd8b5fe47dab091176d21bb6de568acdd906d1887a4584a15a9a96a1dca06ef"
  end

  resource "cp312_arm64" do
    url "https://files.pythonhosted.org/packages/75/5b/ca6c8bd14007e5ca171c7c03102d17b4f4e0ceb53957e8c44343a9546dcc/numpy-1.26.4-cp312-cp312-macosx_11_0_arm64.whl"
    sha256 "03a8c78d01d9781b28a6989f6fa1bb2c4f2d51201cf99d3dd875df6fbd96b23b"
  end

  resource "cp39_x86_64" do
    url "https://files.pythonhosted.org/packages/7d/24/ce71dc08f06534269f66e73c04f5709ee024a1afe92a7b6e1d73f158e1f8/numpy-1.26.4-cp39-cp39-macosx_10_9_x86_64.whl"
    sha256 "7349ab0fa0c429c82442a27a9673fc802ffdb7c7775fad780226cb234965e53c"
  end

  resource "cp310_x86_64" do
    url "https://files.pythonhosted.org/packages/a7/94/ace0fdea5241a27d13543ee117cbc65868e82213fb31a8eb7fe9ff23f313/numpy-1.26.4-cp310-cp310-macosx_10_9_x86_64.whl"
    sha256 "9ff0f4f29c51e2803569d7a51c2304de5554655a60c5d776e35b4a41413830d0"
  end

  resource "cp311_x86_64" do
    url "https://files.pythonhosted.org/packages/11/57/baae43d14fe163fa0e4c47f307b6b2511ab8d7d30177c491960504252053/numpy-1.26.4-cp311-cp311-macosx_10_9_x86_64.whl"
    sha256 "4c66707fabe114439db9068ee468c26bbdf909cac0fb58686a42a24de1760c71"
  end

  resource "cp312_x86_64" do
    url "https://files.pythonhosted.org/packages/95/12/8f2020a8e8b8383ac0177dc9570aad031a3beb12e38847f7129bacd96228/numpy-1.26.4-cp312-cp312-macosx_10_9_x86_64.whl"
    sha256 "b3ce300f3644fb06443ee2222c2201dd3a89ea6040541412b8fa189341847218"
  end

  def install
    arch = Hardware::CPU.arch.to_s
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      # numpy 1.26.4 wheels are available for python >=3.9 <3.13
      if python.gsub("python@3.", "").to_i >= 9 && python.gsub("python@3.", "").to_i < 13
        python_exe = "#{HOMEBREW_PREFIX}/bin/#{python.gsub("@", "")}"
        version = python.gsub("python@", "").gsub(".", "")
        resource("cp#{version}_#{arch}").stage do
          wheel_file = Dir[Pathname.pwd/"numpy*#{arch}.whl"].first
          system python_exe, "-m", "pip", "install", *std_pip_args, wheel_file
        end
      end
    end
  end

  test do
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      if python.gsub("python@3.", "").to_i >= 9 && python.gsub("python@3.", "").to_i < 13
        python_exe = "#{HOMEBREW_PREFIX}/bin/#{python.gsub("@", "")}"
        system python_exe, "-c", <<~EOS
          import numpy as np
          t = np.ones((3,3), int)
          assert t.sum() == 9
          assert np.dot(t, t).sum() == 27
        EOS
      end
    end
  end
end