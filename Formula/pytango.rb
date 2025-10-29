# frozen_string_literal: true

class Pytango < Formula
  desc "Python module for cppTango C++ libraries"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/pytango.git",
      tag: "v10.1.0"
  version "10.1.0"

  depends_on "git" => :build
  depends_on "numpy"
  depends_on "python@3.13"
  depends_on "python-packaging"
  depends_on "mlz/packages/python-typing-extensions"


  resource "cp310_arm64" do
    url "https://files.pythonhosted.org/packages/c5/81/f6215277ba33ab1ca5dbd7c2e8cbaaa2b72bdc97731f9e6e31df6f5d5fdf/pytango-10.1.0-cp310-cp310-macosx_12_0_arm64.whl"
    sha256 "753de16dc1e1252e6c9950038e7ed84f34a52152de0f284219cd076014673fec"
  end

  resource "cp311_arm64" do
    url "https://files.pythonhosted.org/packages/e9/c7/0fe8da89ef1600db6ac1d142f872d6c07c2ef21b7253299aa59f721ea08e/pytango-10.1.0-cp311-cp311-macosx_12_0_arm64.whl"
    sha256 "fff590b5d088e991ac4b86b02644310515fbd56f92107105a225706dab4c7147"
  end

  resource "cp312_arm64" do
    url "https://files.pythonhosted.org/packages/ac/0b/f756ccbf8e731653d9c2262100a9e5302de7c166f2f913f93053e606615c/pytango-10.1.0-cp312-cp312-macosx_12_0_arm64.whl"
    sha256 "70562ca8cf112c4919c51f02b2ff5181d5637f83e354b673e805688dd39c23ee"
  end

  resource "cp313_arm64" do
    url "https://files.pythonhosted.org/packages/7a/ce/e678fc4ba651dc26353ef26501b6936ffe0f6d963ab8e23606af9c3e34cc/pytango-10.1.0-cp313-cp313-macosx_12_0_arm64.whl"
    sha256 "156aff8c15ee980f80d0c1b465471b4fafefce157af52accf0e67b4300d0ab32"
  end

  resource "cp314_arm64" do
    url "https://files.pythonhosted.org/packages/96/9f/e9beea1326ff69056ad5daf0f87ed8be187ed6f9b1ad96065dd831151404/pytango-10.1.0-cp314-cp314-macosx_12_0_arm64.whl"
    sha256 "3b61e2eb91558919b9ecd94f13d544f3e0c8e9957108c3b06c0b7a7084d0603e"
  end

  resource "cp310_x86_64" do
    url "https://files.pythonhosted.org/packages/9b/85/f2ff9535ce033b8bf692bc1057140ddd646baaab1bc45de50a537e15d70c/pytango-10.1.0-cp310-cp310-macosx_12_0_x86_64.whl"
    sha256 "b0e62be26142f723a6fd2a77461cfcaabc07edd2b5e03251bea5223f4bcfa679"
  end

  resource "cp311_x86_64" do
    url "https://files.pythonhosted.org/packages/03/08/25fa0a5cbf25c5c8ce85e7963f228d65dc5b874daac61ebcca4cd85f7b3b/pytango-10.1.0-cp311-cp311-macosx_12_0_x86_64.whl"
    sha256 "696818b8a69fc015cecafccd3bdd5ddb755fcaa2683851f7079d5216947ca336"
  end

  resource "cp312_x86_64" do
    url "https://files.pythonhosted.org/packages/2e/1e/1657c03929407be4613410349f0f7405d6fe77be9c2a6ba93e5adc07f0a9/pytango-10.1.0-cp312-cp312-macosx_12_0_x86_64.whl"
    sha256 "e960bc041603e4039deedca0181bdfb0f75ce75438c8915963475e7e35a6def6"
  end

  resource "cp313_x86_64" do
    url "https://files.pythonhosted.org/packages/68/9b/50d4b2ef75a3ffa0b53b6c3c8bc08c6a3ed14a29cd1b8a9712de6a4d338e/pytango-10.1.0-cp313-cp313-macosx_12_0_x86_64.whl"
    sha256 "ed5977d4e64063a8ff61c2058149f96f947338305b05f2b989f91e033499e336"
  end

  resource "cp314_x86_64" do
    url "https://files.pythonhosted.org/packages/4f/a7/1fbbd14470868d4945ff3b02cbdc5d9dc0c0caa3a9037e934383d1cd49d4/pytango-10.1.0-cp314-cp314-macosx_12_0_x86_64.whl"
    sha256 "39bc00e4b2dd3ec30304ee64830ea4e4ec7aedd79276e2a467e78eea2e9f2394"
  end


  def install
    arch = Hardware::CPU.arch.to_s
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      # available for >=3.9 <3.14
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
