# frozen_string_literal: true

class Pytango < Formula
  desc "Python module for cppTango C++ libraries"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/pytango.git",
      tag: "v10.1.2"
  version "10.1.2"

  depends_on "git" => :build
  depends_on "numpy"
  depends_on "python@3.14"
  depends_on "python-packaging"
  depends_on "mlz/packages/python-typing-extensions"


  resource "cp310_arm64" do
    url "https://files.pythonhosted.org/packages/01/bc/7b4be1167e3cdee64b46f460e128ace18b215becdfcc401442252927fd74/pytango-10.1.2-cp310-cp310-macosx_12_0_arm64.whl"
    sha256 "77ab5df70ec9475bb017274209f0f9180b39adaffa92330cb3424b518b27e936"
  end

  resource "cp311_arm64" do
    url "https://files.pythonhosted.org/packages/60/13/9076532e82b2ce31986e7977fb3174b65e63f30e30bae009aac7d4805f9c/pytango-10.1.2-cp311-cp311-macosx_12_0_arm64.whl"
    sha256 "b0d15c4744922f6856ff55d510750513f15dcbc24b21477a25d4031a982f997b"
  end

  resource "cp312_arm64" do
    url "https://files.pythonhosted.org/packages/52/fd/85114c358587f33e7678b55506f2f642d27bd79c466016bb5089e9ff75cc/pytango-10.1.2-cp312-cp312-macosx_12_0_arm64.whl"
    sha256 "a059605db436f0bd9b0fddfa652199871d34ea01d12bc1edb93f62e2bbba4f55"
  end

  resource "cp313_arm64" do
    url "https://files.pythonhosted.org/packages/ec/35/3c3d8db9398811bfc7510e989a0849ca66854a9777272818014744d17184/pytango-10.1.2-cp313-cp313-macosx_12_0_arm64.whl"
    sha256 "21b463269b4ad5649f6054c9b2ed385991c969d2eddf8111d7ae73fd0f91582d"
  end

  resource "cp314_arm64" do
    url "https://files.pythonhosted.org/packages/15/f2/9e9a78a7cf8723bbc3c795f7dfd01b5764ef01a91f99241cfef2d76b75c1/pytango-10.1.2-cp314-cp314-macosx_12_0_arm64.whl"
    sha256 "7ca1ce094d347fbe9b324652f63ef73481fa99f77da62af783989c35be1be118"
  end

  resource "cp310_x86_64" do
    url "https://files.pythonhosted.org/packages/97/1a/10f541e83e48f8d211c5182513ecf218b8412d4469944407d7cd8b849958/pytango-10.1.2-cp310-cp310-macosx_12_0_x86_64.whl"
    sha256 "2baeec370fc733bcabf9436311db55f2756828caa97d80f62a18dd93d5e773f6"
  end

  resource "cp311_x86_64" do
    url "https://files.pythonhosted.org/packages/85/47/e9c1467b125ee924da5885f1631378f4ebc6a50b1a978792366d83db1124/pytango-10.1.2-cp311-cp311-macosx_12_0_x86_64.whl"
    sha256 "519f345d13d6516ea821fdbc96fe907327ce43ee33ecf2fef859393768bc2568"
  end

  resource "cp312_x86_64" do
    url "https://files.pythonhosted.org/packages/c8/06/773e566e468e28e162350d44f52341909fac610e1ed294dc32c8874bd4d8/pytango-10.1.2-cp312-cp312-macosx_12_0_x86_64.whl"
    sha256 "9c126c1436132d385f0fc774f999d214cad4848144275da20219866b6d551e71"
  end

  resource "cp313_x86_64" do
    url "https://files.pythonhosted.org/packages/e3/9d/bed7b9e5134d346dd3ce50d24987fe551732eb7f335b13c53473e025e657/pytango-10.1.2-cp313-cp313-macosx_12_0_x86_64.whl"
    sha256 "699bd108ad81f2ee691b63888e8269e088d021a88e5ea01a4c010a5ee64c69c3"
  end

  resource "cp314_x86_64" do
    url "https://files.pythonhosted.org/packages/74/f0/b7d408ad36a526ffc043a22487055e48346dc1a92488a730c92eaee0bd4b/pytango-10.1.2-cp314-cp314-macosx_12_0_x86_64.whl"
    sha256 "5dcc8058b4f0d956efea5c3416a059a47196a192a1eea7420ff619f8ffe0f904"
  end


  def install
    arch = Hardware::CPU.arch.to_s
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      # available for >=3.9 <3.15
      if python.gsub("python@3.", "").to_i >= 10 && python.gsub("python@3.", "").to_i < 15
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
      if python.gsub("python@3.", "").to_i >= 10 && python.gsub("python@3.", "").to_i < 15
        python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
        system python_exe, "-c", "from tango import DeviceProxy"
      end
    end
  end
end
