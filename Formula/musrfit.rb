# frozen_string_literal: true

class Musrfit < Formula
  desc "muSR and beta-NMR data analysis package."
  homepage "https://lmu.web.psi.ch/musrfit/user/html/index.html"
  url "https://bitbucket.org/muonspin/musrfit.git",
      tag: "v1.11.2"
  version "1.11.2"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "gsl"
  depends_on "fftw"
  depends_on "libxml2"
  depends_on "qt"
  depends_on "root"
  depends_on "vdt"
  depends_on "mlz/packages/nexus-format"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    git_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix git`.strip
    pkgconfig_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix pkg-config`.strip
    boost_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix boost`.strip
    gsl_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix gsl`.strip
    fftw_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix fftw`.strip
    hdf5_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix hdf5`.strip
    libxml2_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix libxml2`.strip
    nexus_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix nexus-format`.strip
    nlohmann_json_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix nlohmann-json`.strip
    qt_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix qt`.strip
    vdt_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix vdt`.strip
    root_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix root`.strip
    brew_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix`.strip
    repo_path = `#{HOMEBREW_PREFIX}/bin/brew --repository mlz/packages`.strip
    system "patch -p1 < #{repo_path}/patches/musrfit0.patch"
    system "patch -p1 < #{repo_path}/patches/musrfit1.patch"
    mkdir "build" do
      system "#{HOMEBREW_PREFIX}/bin/cmake",
             "..",
             "-DMUSRFIT_INSTALL_PREFIX=#{brew_path}/opt/musrfit",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DCMAKE_CXX_STANDARD=17",
             "-DPkgConfig=#{pkgconfig_path}",
             "-DGit_ROOT=#{git_path}",
             "-DBoost_ROOT=#{boost_path}",
             "-DGSL_ROOT=#{gsl_path}",
             "-DFFTW3_ROOT=#{fftw_path}",
             "-DHDF5_ROOT=#{hdf5_path}",
             "-DLibXml2=#{libxml2_path}",
             "-Dnexus=1",
             "-DNEXUS_ROOT=#{nexus_path}",
             "-DNEXUS_INCLUDE_DIR=#{nexus_path}/include/nexus",
             "-Dnlohmann_json_DIR=#{nlohmann_json_path}/share/cmake/nlohmann_json",
             "-Dqt_version=6",
             "-Dqt_based_tools=0",
             "-DCMAKE_PREFIX_PATH=#{qt_path}",
             "-DROOT_ROOT=#{root_path}",
             "-DVDT_LIBRARY=#{vdt_path}/lib/libvdt.dylib",
             "-DVDT_INCLUDE_DIR=#{vdt_path}/include",
             "-DCMAKE_INSTALL_PREFIX=./install"
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--build", ".", "--parallel", cores.to_s
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--install", "."
      prefix.install Dir["install/*"]
      system "rm", "-rf", "*"
      system "#{HOMEBREW_PREFIX}/bin/cmake",
             "..",
             "-DMUSRFIT_INSTALL_PREFIX=#{brew_path}/opt/musrfit",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DCMAKE_CXX_STANDARD=17",
             "-DPkgConfig=#{pkgconfig_path}",
             "-DGit_ROOT=#{git_path}",
             "-DBoost_ROOT=#{boost_path}",
             "-DGSL_ROOT=#{gsl_path}",
             "-DFFTW3_ROOT=#{fftw_path}",
             "-DHDF5_ROOT=#{hdf5_path}",
             "-DLibXml2=#{libxml2_path}",
             "-Dnexus=1",
             "-DNEXUS_ROOT=#{nexus_path}",
             "-DNEXUS_INCLUDE_DIR=#{nexus_path}/include/nexus",
             "-Dnlohmann_json_DIR=#{nlohmann_json_path}/share/cmake/nlohmann_json",
             "-Dqt_version=6",
             "-Dqt_based_tools=1",
             "-DCMAKE_PREFIX_PATH=#{qt_path}",
             "-DROOT_ROOT=#{root_path}",
             "-DVDT_LIBRARY=#{vdt_path}/lib/libvdt.dylib",
             "-DVDT_INCLUDE_DIR=#{vdt_path}/include",
             "-DCMAKE_INSTALL_PREFIX=./install"
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--build", ".", "--parallel", cores.to_s
      prefix.install "src/musredit_qt6/mupp/mupp.app"
      prefix.install "src/musredit_qt6/musredit/musredit.app"
      prefix.install "src/musredit_qt6/musrStep/musrStep.app"
      prefix.install "src/musredit_qt6/musrWiz/musrWiz.app"

      musrfit_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix musrfit`.strip
      exe = "musredit"
      exe_content = <<~BASH
        #!/bin/bash
        DYLD_LIBRARY_PATH=#{musrfit_path}/lib MUSRFITPATH=#{musrfit_path}/bin ROOTSYS=#{musrfit_path} open #{musrfit_path}/musredit.app
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
