# frozen_string_literal: true

class Musrfit < Formula
  desc "Software tool for analyzing time-differential μSR data."
  homepage "https://lmu.web.psi.ch/musrfit/user/html/index.html"
  url "https://bitbucket.org/muonspin/musrfit.git",
      tag: "v1.9.1"
  version "1.9.1"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "gsl"
  depends_on "fftw"
  depends_on "qt@5"
  depends_on "root"
  depends_on "mlz/packages/nexus-format"

  def install
    cores = `sysctl -n hw.ncpu`.strip
    qt5_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix qt@5`.strip
    nexus_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix nexus`.strip
    nlohmann_json_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix nlohmann-json`.strip
    mkdir "build" do
      system "CC=/usr/bin/clang CXX=/usr/bin/clang++ " +
               "#{HOMEBREW_PREFIX}/bin/cmake .. -DCMAKE_BUILD_TYPE=Release " +
               "-Dnexus=1 -DNEXUS_INCLUDE_DIR=#{nexus_path}/include/nexus " +
               "-Dqt_version=5 -DCMAKE_PREFIX_PATH=#{qt5_path} " +
               "-Dnlohmann_json_DIR=#{nlohmann_json_path}/share/cmake/nlohmann_json " +
               "-DCMAKE_INSTALL_PREFIX=./install -Dqt_based_tools=0"
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--build", ".", "--parallel", cores.to_s
      system "#{HOMEBREW_PREFIX}/bin/cmake", "--install", "."
      prefix.install Dir["install/*"]
      system "rm", "-rf", "*"
      system "CC=/usr/bin/clang CXX=/usr/bin/clang++ " +
               "#{HOMEBREW_PREFIX}/bin/cmake .. -DCMAKE_BUILD_TYPE=Release " +
               "-Dnexus=1 -DNEXUS_INCLUDE_DIR=#{nexus_path}/include/nexus " +
               "-Dqt_version=5 -DCMAKE_PREFIX_PATH=#{qt5_path} " +
               "-Dnlohmann_json_DIR=#{nlohmann_json_path}/share/cmake/nlohmann_json " +
               "-DCMAKE_INSTALL_PREFIX=#{buildpath}/install -Dqt_based_tools=1"
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
