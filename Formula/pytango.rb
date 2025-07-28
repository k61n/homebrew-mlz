# frozen_string_literal: true

class Pytango < Formula
  desc "Python module for cppTango C++ libraries"
  homepage "https://www.tango-controls.org/"
  url "https://gitlab.com/tango-controls/pytango.git",
      tag: "v10.0.3"
  version "10.0.3"

  depends_on "git" => :build
  depends_on "numpy"
  depends_on "python-packaging"
  depends_on "mlz/packages/python-typing-extensions"


  resource "cp39_arm64" do
    url "https://files.pythonhosted.org/packages/81/35/21e88c717fe730ccf6c7f910b27c6fc817d3ce3eacf70d18b6dc0619dfaf/pytango-10.0.3-cp39-cp39-macosx_12_0_arm64.whl"
    sha256 "777967d6d4f10f662941a1dcde984f89066b1d43d263192decbcd3ea7987d312"
  end

  resource "cp310_arm64" do
    url "https://files.pythonhosted.org/packages/39/74/e0592346d74429f9aa5c759a94b343c204d08ec8184e9c61f93bb3f36431/pytango-10.0.3-cp310-cp310-macosx_12_0_arm64.whl"
    sha256 "14a091601cab6af84f5ee255dd7f114ad67e9bc724b367099d13d994c8036ae6"
  end

  resource "cp311_arm64" do
    url "https://files.pythonhosted.org/packages/11/a2/cfc28130704b44bae89d0cdec0e5f20878b5ef8a8bd7a822256fd5be335f/pytango-10.0.3-cp311-cp311-macosx_12_0_arm64.whl"
    sha256 "51464e31b63b9f80687f84d9ece6d79ca82e8f5c483ccabf07c973cba15fd9d5"
  end

  resource "cp312_arm64" do
    url "https://files.pythonhosted.org/packages/ed/fc/fdae94bcea73fc3e2952b89bf56f66512dff99bf3b9700fc0f585b2c8f98/pytango-10.0.3-cp312-cp312-macosx_12_0_arm64.whl"
    sha256 "b90db10d2fe44c81260f91bf7e61949e5a913ff9f5909017d27a90a2a595e181"
  end

  resource "cp313_arm64" do
    url "https://files.pythonhosted.org/packages/a4/a0/290468cd6d4038745d1de2cc58911c2e8596a9aa8d66b352802f96925292/pytango-10.0.3-cp313-cp313-macosx_12_0_arm64.whl"
    sha256 "9a3f648f7dd66eeac5786ff9e315afa100064ff5873145d5c79a41321b56a57a"
  end

  resource "cp39_x86_64" do
    url "https://files.pythonhosted.org/packages/5c/3c/ac23dbd3049434f2a4dd92dc2f7c83a7bef2dd0acc8f758ac26c1d6776bc/pytango-10.0.3-cp39-cp39-macosx_12_0_x86_64.whl"
    sha256 "515b6a59bdada204e020e8f91c682392e015a428fdfb2a32041c10300fbffc58"
  end

  resource "cp310_x86_64" do
    url "https://files.pythonhosted.org/packages/a7/f6/b639cf469a64089b62d40b4c41c117b608e968a644d50952783cd53a0288/pytango-10.0.3-cp310-cp310-macosx_12_0_x86_64.whl"
    sha256 "82608e6d90666a248b6913c9b03f5a8b3d65a5a1c87acb004e22ec2326ef5a28"
  end

  resource "cp311_x86_64" do
    url "https://files.pythonhosted.org/packages/b8/de/6774df781401aab59602c4dfbdc8fd17ceabdc546f5ed2248e0156b739d9/pytango-10.0.3-cp311-cp311-macosx_12_0_x86_64.whl"
    sha256 "44ca2954feed026d55808b763b6666c58763cda60c6d5ab84867f2381b6ce705"
  end

  resource "cp312_x86_64" do
    url "https://files.pythonhosted.org/packages/cf/16/1e0e4d77c58e2eb3ead15aacbb852fed2343cb9a4c92022ea6b8c0297acf/pytango-10.0.3-cp312-cp312-macosx_12_0_x86_64.whl"
    sha256 "ff313775ea4eb07224926026d48caa5fb41e143a61c17da626513834876b1b95"
  end

  resource "cp313_x86_64" do
    url "https://files.pythonhosted.org/packages/2c/54/e3cf1229f8f24b9f5323a09968828a3919742dc3931769a1f0892fa20f2b/pytango-10.0.3-cp313-cp313-macosx_12_0_x86_64.whl"
    sha256 "07be8db2b72fe339ab525cabb3f0c5c833bbe47f685ab440ec99c4116b9d19de"
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
