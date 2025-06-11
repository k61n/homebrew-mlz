# frozen_string_literal: true

class Musrfit < Formula
  desc "muSR and beta-NMR data analysis package."
  homepage "https://lmu.web.psi.ch/musrfit/user/html/index.html"
  url "https://bitbucket.org/muonspin/musrfit.git",
      tag: "v1.9.9"
  version "1.9.9"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "gsl"
  depends_on "fftw"
  depends_on "libxml2"
  depends_on "qt@5"
  depends_on "root"
  depends_on "mlz/packages/hdf4"
  depends_on "mlz/packages/nexus-format"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    pkgconfig_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix pkg-config`.strip
    git_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix git`.strip
    boost_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix boost`.strip
    gsl_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix gsl`.strip
    fftw_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix fftw`.strip
    hd4_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix hdf4`.strip
    hd5_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix hdf5`.strip
    libxml2_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix libxml2`.strip
    nexus_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix nexus-format`.strip
    nlohmann_json_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix nlohmann-json`.strip
    qt5_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix qt@5`.strip
    root_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix root`.strip
    mkdir "build" do
      system "#{HOMEBREW_PREFIX}/bin/cmake",
             "..",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DCMAKE_CXX_STANDARD=17",
             "-DPkgConfig=#{pkgconfig_path}",
             "-DGit_ROOT=#{git_path}",
             "-DBoost_ROOT=#{boost_path}",
             "-DGSL_ROOT=#{gsl_path}",
             "-DFFTW3_ROOT=#{fftw_path}",
             "-DHDF4_ROOT=#{hd4_path}",
             "-DHDF5_ROOT=#{hd5_path}",
             "-DLibXml2=#{libxml2_path}",
             "-Dnexus=1",
             "-DNEXUS_ROOT=#{nexus_path}",
             "-DNEXUS_INCLUDE_DIR=#{nexus_path}/include/nexus",
             "-Dnlohmann_json_DIR=#{nlohmann_json_path}/share/cmake/nlohmann_json",
             "-Dqt_version=5",
             "-Dqt_based_tools=0",
             "-DCMAKE_PREFIX_PATH=#{qt5_path}",
             "-DROOT_ROOT=#{root_path}",
             "-DVDT_LIBRARY=#{root_path}/lib/root/libvdt.dylib",
             "-DVDT_INCLUDE_DIR=#{root_path}/include/root",
             "-DCMAKE_INSTALL_PREFIX=./install"
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--build", ".", "--parallel", cores.to_s
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--install", "."
      prefix.install Dir["install/*"]
      system "rm", "-rf", "*"
      system "#{HOMEBREW_PREFIX}/bin/cmake",
             "..",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DCMAKE_CXX_STANDARD=17",
             "-DPkgConfig=#{pkgconfig_path}",
             "-DGit_ROOT=#{git_path}",
             "-DBoost_ROOT=#{boost_path}",
             "-DGSL_ROOT=#{gsl_path}",
             "-DFFTW3_ROOT=#{fftw_path}",
             "-DHDF4_ROOT=#{hd4_path}",
             "-DHDF5_ROOT=#{hd5_path}",
             "-DLibXml2=#{libxml2_path}",
             "-Dnexus=1",
             "-DNEXUS_ROOT=#{nexus_path}",
             "-DNEXUS_INCLUDE_DIR=#{nexus_path}/include/nexus",
             "-Dnlohmann_json_DIR=#{nlohmann_json_path}/share/cmake/nlohmann_json",
             "-Dqt_version=5",
             "-Dqt_based_tools=1",
             "-DCMAKE_PREFIX_PATH=#{qt5_path}",
             "-DROOT_ROOT=#{root_path}",
             "-DVDT_LIBRARY=#{root_path}/lib/root/libvdt.dylib",
             "-DVDT_INCLUDE_DIR=#{root_path}/include/root",
             "-DCMAKE_INSTALL_PREFIX=./install"
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--build", ".", "--parallel", cores.to_s
      prefix.install "src/musredit_qt5/mupp/mupp.app"
      prefix.install "src/musredit_qt5/musredit/musredit.app"
      prefix.install "src/musredit_qt5/musrStep/musrStep.app"
      prefix.install "src/musredit_qt5/musrWiz/musrWiz.app"

      musrfit_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix musrfit`.strip
      exe = "musredit"
      exe_content = <<~BASH
        #!/bin/bash
        MUSRFITPATH=#{musrfit_path}/bin ROOTSYS=#{musrfit_path} open #{musrfit_path}/musredit.app
      BASH
      File.open(exe, "w") do |file|
        file.write(exe_content)
        File.chmod(0755, exe)
        bin.install exe
      end
    end
  end

  def post_install
    puts "To use MusrFit Editor, relaunch terminal and call"
    puts "  musredit"
  end

  test do
    # Test commands to verify that your software is working
  end
end
