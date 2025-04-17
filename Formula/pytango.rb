# frozen_string_literal: true

class Pytango < Formula
  desc "Python module for cppTango C++ libraries"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/pytango.git",
      tag: "v10.0.2"
  version "10.0.2"

  depends_on "git" => :build
  depends_on "numpy"
  depends_on "python-packaging"
  depends_on "mlz/packages/python-typing-extensions"


  resource "cp39_arm64" do
    url "https://files.pythonhosted.org/packages/5a/3f/2ae51015acb0ab71772248527504e53c75f033dc069c3ade5cd97f8ea2ca/pytango-10.0.2-cp39-cp39-macosx_12_0_arm64.whl"
    sha256 "07b72c1d74346bd276a7c0a84e557806ee7d351e65246cda5b8128323111392f"
  end

  resource "cp310_arm64" do
    url "https://files.pythonhosted.org/packages/39/38/042f229a58029ffc7ca216ab335aec25576ff00bef87f09f4c3505f248c7/pytango-10.0.2-cp310-cp310-macosx_12_0_arm64.whl"
    sha256 "b266c717460bbb6b02cb97eaf4c2ce230538b118a33e30da37c27b31b1f5f52f"
  end

  resource "cp311_arm64" do
    url "https://files.pythonhosted.org/packages/eb/d6/d74e3d26ddc0de639c0187334288d63de28ab4002cdfb38c62c885edc909/pytango-10.0.2-cp311-cp311-macosx_12_0_arm64.whl"
    sha256 "4e9320807ad5975a48e68db1fef5fa932a3971a534d55b0c5df21ef85c8b7b31"
  end

  resource "cp312_arm64" do
    url "https://files.pythonhosted.org/packages/2f/8d/f8b4db3aadc46a059e9b571f25be2818634abc84e41b1609ae614ab2abdb/pytango-10.0.2-cp312-cp312-macosx_12_0_arm64.whl"
    sha256 "37677cf9068ec560e5ac2c92eba6e337d7fc077964531cf1784c04b98903733a"
  end

  resource "cp313_arm64" do
    url "https://files.pythonhosted.org/packages/35/95/02acab0ddb31d839ede6f43e9f1a1c8cac5261bf45df418f602fa3caf550/pytango-10.0.2-cp313-cp313-macosx_12_0_arm64.whl"
    sha256 "49ae5a4450062a94e51ebf894bb44dc96c1f7b02e9bd54dcf6c9bd734a026e96"
  end

  resource "cp39_x86_64" do
    url "https://files.pythonhosted.org/packages/63/36/7fe21490552b2f8370d1e401a07c9eed92d357a5aaf5e2d393aafba1acf3/pytango-10.0.2-cp39-cp39-macosx_12_0_x86_64.whl"
    sha256 "f7cf46b9190cc1f6f52fafe32dc4dcf9f54c9a9cfeb452de8b25bca9c752c116"
  end

  resource "cp310_x86_64" do
    url "https://files.pythonhosted.org/packages/6d/ec/ee0ceefb57191bd2f7c49765f12b763b4feea967ffd1eceb8175e3a09a7f/pytango-10.0.2-cp310-cp310-macosx_12_0_x86_64.whl"
    sha256 "06ac20a53a619e836d74cb402cfb638d0cf499f2836cba61a0a02b4309f1f663"
  end

  resource "cp311_x86_64" do
    url "https://files.pythonhosted.org/packages/d1/88/ee762aaea8d744686b88cd2d0b54618f99f73109c563a38e35ece7c51697/pytango-10.0.2-cp311-cp311-macosx_12_0_x86_64.whl"
    sha256 "803747e11a7a94431f302a58650066d80d900bb5640568928d8a0d454a36c702"
  end

  resource "cp312_x86_64" do
    url "https://files.pythonhosted.org/packages/b2/8c/12436aeaee75465d8ee077d5fcd8eb73d49a325066daf552295361f0a6e2/pytango-10.0.2-cp312-cp312-macosx_12_0_x86_64.whl"
    sha256 "42e9a2bbb925531e5b5e119176af5e18baefeb200942744dce168ee42ed67795"
  end

  resource "cp313_x86_64" do
    url "https://files.pythonhosted.org/packages/49/a8/f5a47ca9fef44ac0d2a8eda5487f6bd507a77ed0ad766c30527d760d0dbf/pytango-10.0.2-cp313-cp313-macosx_12_0_x86_64.whl"
    sha256 "3ab89fefeed30637e641d45920d376847688efb0f95543f329b0020f64961a41"
  end


  def install
    arch = Hardware::CPU.arch.to_s
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      # available for >=3.9 <3.14
      if python.gsub("python@3.", "").to_i >= 9 && python.gsub("python@3.", "").to_i < 14
        python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
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
      python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
      system python_exe, "-c", "from tango import DeviceProxy"
    end
  end
end
