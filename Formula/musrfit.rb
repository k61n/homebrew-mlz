# frozen_string_literal: true

class Musrfit < Formula
  desc "Software tool for analyzing time-differential μSR data."
  homepage "https://lmu.web.psi.ch/musrfit/user/html/index.html"
  url "https://bitbucket.org/muonspin/musrfit.git",
      tag: "v1.9.2"
  version "1.9.2"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "gsl"
  depends_on "fftw"
  depends_on "qt@5"
  depends_on "root"
  depends_on "xml2"
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
    xml2_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix xml2`.strip
    nexus_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix nexus-format`.strip
    nlohmann_json_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix nlohmann-json`.strip
    qt5_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix qt@5`.strip
    root_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix root`.strip
    mkdir "build" do
      system "CC=/usr/bin/clang CXX=/usr/bin/clang++ " +
             "#{HOMEBREW_PREFIX}/bin/cmake .. " +
             "-DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=17 " +
             "-DPkgConfig=#{pkgconfig_path} " +
             "-DGit_ROOT=#{git_path} " +
             "-DBoost_ROOT=#{boost_path} " +
             "-DGSL_ROOT=#{gsl_path} " +
             "-DFFTW3_ROOT=#{fftw_path} " +
             "-DHDF4_ROOT=#{hd4_path} " +
             "-DHDF5_ROOT=#{hd5_path} " +
             "-DLibXml2=#{xml2_path} " +
             "-Dnexus=1 -DNEXUS_ROOT=#{nexus_path} " +
             "-DNEXUS_INCLUDE_DIR=#{nexus_path}/include/nexus " +
             "-Dnlohmann_json_DIR=#{nlohmann_json_path}/share/cmake/nlohmann_json " +
             "-Dqt_version=5 -Dqt_based_tools=0 " +
             "-DCMAKE_PREFIX_PATH=#{qt5_path} " +
             "-DROOT_ROOT=#{root_path} " +
             "-DCMAKE_INSTALL_PREFIX=./install"
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--build", ".", "--parallel", cores.to_s
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--install", "."
      prefix.install Dir["install/*"]
      system "rm", "-rf", "*"
      system "CC=/usr/bin/clang CXX=/usr/bin/clang++ " +
             "#{HOMEBREW_PREFIX}/bin/cmake .. " +
             "-DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=17 " +
             "-DPkgConfig=#{pkgconfig_path} " +
             "-DGit_ROOT=#{git_path} " +
             "-DBoost_ROOT=#{boost_path} " +
             "-DGSL_ROOT=#{gsl_path} " +
             "-DFFTW3_ROOT=#{fftw_path} " +
             "-DHDF4_ROOT=#{hd4_path} " +
             "-DHDF5_ROOT=#{hd5_path} " +
             "-DLibXml2=#{xml2_path} " +
             "-Dnexus=1 -DNEXUS_ROOT=#{nexus_path} " +
             "-DNEXUS_INCLUDE_DIR=#{nexus_path}/include/nexus " +
             "-Dnlohmann_json_DIR=#{nlohmann_json_path}/share/cmake/nlohmann_json " +
             "-Dqt_version=5 -Dqt_based_tools=1 " +
             "-DCMAKE_PREFIX_PATH=#{qt5_path} " +
             "-DROOT_ROOT=#{root_path} " +
             "-DCMAKE_INSTALL_PREFIX=./install"
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--build", ".", "--parallel", cores.to_s
      prefix.install "src/musredit_qt5/mupp/mupp.app"
      prefix.install "src/musredit_qt5/musredit/musredit.app"
      prefix.install "src/musredit_qt5/musrStep/musrStep.app"
      prefix.install "src/musredit_qt5/musrWiz/musrWiz.app"
    end
  end

  def post_install
    puts "############################################################"
    puts "# Important post install actions ###########################"
    puts "############################################################"
    puts ""
    musrfit_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix musrfit`.strip
    puts "You can load museredit using following shell command:"
    puts "MUSRFITPATH=#{musrfit_path}/bin ROOTSYS=#{musrfit_path} open #{musrfit_path}/musredit.app"
    puts "It is recommended to create an Application with Automator using this shell command."
    puts ""
    puts "############################################################"
  end

  test do
    # Test commands to verify that your software is working
  end
end
