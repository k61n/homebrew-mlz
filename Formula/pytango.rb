# frozen_string_literal: true

class Pytango < Formula
  desc "Python module for cppTango C++ libraries"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/pytango.git",
      tag: "v10.1.1"
  version "10.1.1"

  depends_on "git" => :build
  depends_on "numpy"
  depends_on "python@3.13"
  depends_on "python-packaging"
  depends_on "mlz/packages/python-typing-extensions"


  resource "cp310_arm64" do
    url "https://files.pythonhosted.org/packages/fc/2a/88d929d956bda0691553d3fbbdd176f3adffd8767a5ba97f4a42a1c4c4f5/pytango-10.1.1-cp310-cp310-macosx_12_0_arm64.whl"
    sha256 "a72da3e15fa2342a56f4c08f6562ea5f8515c6d0f035de71aad3f69e09ecce1b"
  end

  resource "cp311_arm64" do
    url "https://files.pythonhosted.org/packages/57/cb/34bf50b215cf9eda5730c4f584952145f3dd9b3562efe3bd390dbedd5816/pytango-10.1.1-cp311-cp311-macosx_12_0_arm64.whl"
    sha256 "10b9ea952cec8dbcf11e5c9d34e89c2748f4ead560857211ace9dca79a441c45"
  end

  resource "cp312_arm64" do
    url "https://files.pythonhosted.org/packages/88/4c/7e0674e8a85a2623e67ea9c3868e9249551fa191132729027de184c920e1/pytango-10.1.1-cp312-cp312-macosx_12_0_arm64.whl"
    sha256 "6aa22ddd0d5def86e8a50b28e2bbdfe38286d44539c8a9512cee3ad6289de63f"
  end

  resource "cp313_arm64" do
    url "https://files.pythonhosted.org/packages/15/2a/2c20efe5a19911d65e0b28f68013c667eec0194ce724d1bf639908bcf3ee/pytango-10.1.1-cp313-cp313-macosx_12_0_arm64.whl"
    sha256 "a6c886d79f9084eccbe09a6a6989779a82f41fc878891bb5a9095b82e2e04f88"
  end

  resource "cp314_arm64" do
    url "https://files.pythonhosted.org/packages/38/08/f462da4e23667a1f09b25f0fae1a498b5fa4db8bd8984a9ed75b5765c295/pytango-10.1.1-cp314-cp314-macosx_12_0_arm64.whl"
    sha256 "eb695b2fe7211e85f953d459cace5c79767bab44441c03efccbd08075c48a4a3"
  end

  resource "cp310_x86_64" do
    url "https://files.pythonhosted.org/packages/44/53/fbc2966267caf6625dff9e3899aaa5be054c749e8be7bece29b8f5c57feb/pytango-10.1.1-cp310-cp310-macosx_12_0_x86_64.whl"
    sha256 "ab5edc0f5344a81263ca4172b765d30399fe80c1849b0ce41331ffbbf45bd092"
  end

  resource "cp311_x86_64" do
    url "https://files.pythonhosted.org/packages/b5/49/8c1de4028e625cc0b81554adc88f2cd367fe065856cf745fc26c02862d25/pytango-10.1.1-cp311-cp311-macosx_12_0_x86_64.whl"
    sha256 "fee39e4aa638e1b12ca163e0ae5a9b24a20a7325b1e1f55ebe30501ca9fe00db"
  end

  resource "cp312_x86_64" do
    url "https://files.pythonhosted.org/packages/fd/17/715349f54a73bdb224b7964d98eacb0a4215408a1e13d8dad2442e7f0cc2/pytango-10.1.1-cp312-cp312-macosx_12_0_x86_64.whl"
    sha256 "31bd8550161d80f41772cd20274dbda66b7898f14055cffcb00d5a26ac557639"
  end

  resource "cp313_x86_64" do
    url "https://files.pythonhosted.org/packages/df/f5/f38fd564fa05ce182abbf48562397f8d203a8d5ad943dcdff8d85366d0d4/pytango-10.1.1-cp313-cp313-macosx_12_0_x86_64.whl"
    sha256 "6990f3fef97946ec7f40e92f02c09557481f63cde9ad72797e46fa569919300e"
  end

  resource "cp314_x86_64" do
    url "https://files.pythonhosted.org/packages/cf/79/2a3637c09a72232f40562000f6da2d282b7468832d2caafaf18dc63288ae/pytango-10.1.1-cp314-cp314-macosx_12_0_x86_64.whl"
    sha256 "69c891e24c1c22c3bdabfb70bc3d3a57bbbcefb938a8e85dbf8a2e238d6676a5"
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
