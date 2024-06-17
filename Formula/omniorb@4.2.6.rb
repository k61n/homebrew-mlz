# frozen_string_literal: true

class OmniorbAT426 < Formula
  desc "CORBA object request broker for C++."
  homepage "https://sourceforge.net/projects/omniorb/"
  url "svn://svn.code.sf.net/p/omniorb/svn/tags/4_2_6/omniORB"
  version "4.2.6"

  depends_on "make" => :build
  depends_on "subversion" => :build
  depends_on "python"
  depends_on "python-setuptools"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    mkdir "build" do
      system "../configure", "PYTHON=#{HOMEBREW_PREFIX}/bin/python3",
               "--prefix=#{buildpath}/install"
      system "#{HOMEBREW_PREFIX}/bin/gmake", "-j", cores
      system "#{HOMEBREW_PREFIX}/bin/gmake", "install"
    end
    prefix.install Dir["install/*"]
  end

  test do
    # Test commands to verify that your software is working
  end
end
