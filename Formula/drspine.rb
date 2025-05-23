# frozen_string_literal: true

class Drspine < Formula
  desc "Data reduction software for the Neutron Spin Echo method."
  homepage "https://jugit.fz-juelich.de/nse/drspine"
  url "https://jugit.fz-juelich.de/nse/drspine.git",
      tag: "v1.4.3"
  version "1.4.3"

  depends_on "git" => :build
  depends_on "make" => :build
  depends_on "gcc"
  depends_on "python"
  depends_on "python-matplotlib"
  depends_on "python-setuptools"
  depends_on "scipy"
  depends_on "mlz/packages/gr"

  def install
    gcc_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix gcc`.strip
    gr_path = `#{HOMEBREW_PREFIX}/bin/brew --prefix gr`.strip
    system "#{HOMEBREW_PREFIX}/bin/git", "reset", "--hard", "origin/master"
    makefile = "Makefile.def"
    makefile_content = <<~BASH
      # -*- Makefile -*-
      # vim: filetype=make
      DESTDIR    = #{buildpath}/install
      # Default Instrument 1=SNS-NSE, 2=J-NSE
      INSTRUMENT = 2
      FC         = #{gcc_path}/bin/gfortran
      FCFLAGS    = -g
      GRDIR      = #{gr_path}
      LDFLAGS    = -L#{gcc_path}/lib/
    BASH
    File.open(makefile, "w") do |file|
      file.write(makefile_content)
    end
    system "#{HOMEBREW_PREFIX}/bin/gmake", "all"
    system "#{HOMEBREW_PREFIX}/bin/gmake", "install"
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      python_folder = "#{python.gsub("@", "")}"
      (buildpath/"install/lib/#{python_folder}/site-packages").mkpath
      cp_r buildpath/"install/lib/python/drspine", buildpath/"install/lib/#{python_folder}/site-packages/"
      cp_r Dir[buildpath/"install/lib/python/drspine-*"], buildpath/"install/lib/#{python_folder}/site-packages/"
    end
    prefix.install Dir["install/*"]
  end

  test do
    pythons = `#{HOMEBREW_PREFIX}/bin/brew list | grep python@`.strip.split("\n")
    pythons.each do |python|
      python_exe = "#{HOMEBREW_PREFIX}/opt/#{python}/bin/#{python.gsub("@", "")}"
      system python_exe, "-c", "import drspine"
    end
  end
end
