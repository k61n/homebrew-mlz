# frozen_string_literal: true

class PytangoAT95 < Formula
  desc "Python module for cppTango C++ libraries"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/pytango.git",
      tag: "v9.5.1"
  version "9.5.1"

  depends_on "git" => :build
  depends_on "python-packaging"
  depends_on "mlz/packages/numpy@1.26"
  depends_on "mlz/packages/python-packaging-supplement"

  resource "cp39_arm64" do
    url "https://files.pythonhosted.org/packages/5b/e5/17099364db9d2cd607d702495e757536c506f336644a35ed3f4d14c22231/pytango-9.5.1-cp39-cp39-macosx_11_0_arm64.whl"
    sha256 "ad00eb0a49c701f3d081429039c321b5b44f7d7ce2e33bfe48ce7c9d1fe41c30"
  end

  resource "cp310_arm64" do
    url "https://files.pythonhosted.org/packages/68/f9/404c443660e117fbcb4fccdc0bceea2f72d384a7ca765d093e74df9af526/pytango-9.5.1-cp310-cp310-macosx_11_0_arm64.whl"
    sha256 "985b95beafbbe1a327a17d8a4124b23fb71d22575c46a13b0b279436f060a26b"
  end

  resource "cp311_arm64" do
    url "https://files.pythonhosted.org/packages/92/ab/bd398b6a16121c3180c6123f01b1bb900cb7eaff22a0958bc4026ecad48f/pytango-9.5.1-cp311-cp311-macosx_11_0_arm64.whl"
    sha256 "c0a419546c18d454d9cd722893c54589370245a977e8fc7410fb7d9935ea5cd1"
  end

  resource "cp312_arm64" do
    url "https://files.pythonhosted.org/packages/62/f3/852559faf54820b0e827b362ec01c942faeb24d982cebd88f3a24008598c/pytango-9.5.1-cp312-cp312-macosx_11_0_arm64.whl"
    sha256 "b43e869a1979282e8a26e28462b7180c330f1d93b2a7d3190fed377a8f2bb1bb"
  end

  resource "cp39_x86_64" do
    url "https://files.pythonhosted.org/packages/64/2a/7bd43e8f626edc0312c74a80a76fb2c45cd59e352e297c516b79c74dfd98/pytango-9.5.1-cp39-cp39-macosx_10_9_x86_64.whl"
    sha256 "c322fe04ab9b88cf26d77ba7b9eae342a16d9503c6aa4b66745d163ebcb0adc7"
  end

  resource "cp310_x86_64" do
    url "https://files.pythonhosted.org/packages/dc/3f/f761c2edf97f929b27955d6b4e61d07ad63094b095d4e6a82bc4a2e05640/pytango-9.5.1-cp310-cp310-macosx_10_9_x86_64.whl"
    sha256 "069500a08312f653742bb4406fa87b20f185c986622be797792f57629a6cd706"
  end

  resource "cp311_x86_64" do
    url "https://files.pythonhosted.org/packages/de/1a/85017248f93becd51fa524d835a86de053983bef9c0d9f65938eeb8de932/pytango-9.5.1-cp311-cp311-macosx_10_9_x86_64.whl"
    sha256 "0e284385cb44971c28e3316be57c0152ff3582da3a78570755c388e8b91f4562"
  end

  resource "cp312_x86_64" do
    url "https://files.pythonhosted.org/packages/2b/ce/1d4768aef625eef75138a8dccb737af5f94b27a0cf147957fcfdb4368de3/pytango-9.5.1-cp312-cp312-macosx_10_9_x86_64.whl"
    sha256 "a8e9f44c12c606f9cfd2b74c4a7f4ba9b9cc0d44c68253a78b1775d69adcd1ba"
  end

  def install
    arch = Hardware::CPU.arch.to_s
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      # since numpy 1.26.4 wheels are available for python >=3.9 <3.13
      if python.gsub("python@3.", "").to_i >= 9 && python.gsub("python@3.", "").to_i < 13
        python_exe = "#{HOMEBREW_PREFIX}/bin/#{python.gsub("@", "")}"
        version = python.gsub("python@", "").gsub(".", "")
        resource("cp#{version}_#{arch}").stage do
          wheel_file = Dir[Pathname.pwd/"pytango*#{arch}.whl"].first
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
        system python_exe, "-c", "from tango import DeviceProxy"
      end
    end
  end
end
