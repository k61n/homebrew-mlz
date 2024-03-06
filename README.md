# MLZ brew formulae collection
This tap contains following packages:
 - gr [v0.73.2](https://github.com/sciapp/gr) - [homepage](https://gr-framework.org)
 - python-vcversioner [v2.16.0.0](https://github.com/habnabit/vcversioner)
 - python-gr [v1.24.0](https://github.com/sciapp/python-gr) - [homepage](https://gr-framework.org)
 - hdf4 [v4.3.0](https://github.com/HDFGroup/hdf4) - [homepage](https://www.hdfgroup.org/solutions/hdf4)
 - musrfit [v1.9.2](https://bitbucket.org/muonspin/musrfit/src/root6/) - [homepage](http://lmu.web.psi.ch/musrfit/user/html/index.html)
 - nexus-format [v4.4.3](https://github.com/nexusformat/code) - [homepage](https://www.nexusformat.org)
 - omniorb@4.2.6 [v4.2.6](https://sourceforge.net/p/omniorb/svn/HEAD/tree/) - [homepage](https://sourceforge.net/projects/omniorb)
 - tangoidl [v5.1.2](https://gitlab.com/tango-controls/tango-idl) - [homepage](https://www.tango-controls.org)
 - cpptango@9.4.2 [v9.4.2](https://gitlab.com/tango-controls/cppTango) - [homepage](https://www.tango-controls.org)
 - cpptango [v9.5.0](https://gitlab.com/tango-controls/cppTango) - [homepage](https://www.tango-controls.org)
 - pytango@9.4.2 [v9.4.2](https://gitlab.com/tango-controls/pytango) - [homepage](https://www.tango-controls.org)

# Installation
```bash
brew tap mlz/packages https://forge.frm2.tum.de/review/mlz/packages/homebrew
brew install [package]
```

# Notes

Gr
--
Gr framework relies on both qt@5 and qt@6, in order for compilation to succeed
```bash
brew install qt@5 qt
brew unlink qt@5 qt
brew install gr python-gr
```

omniORB
-------
Omniorb requires subversion, but due to brew bug one should install subversion
beforehand. Omniorb has been added officially to homebrew, however the version
required for cpptango@9.4.2 is 4.2.5.
Omniorb@4.2.5 formula contains fix [6639](https://sourceforge.net/p/omniorb/svn/6639/)
which solves floating point values conversion on arm processors, which has not
yet been included in release of 4.2 branch.
```bash
brew install subversion
brew install omniorb@4.2.5
```

Tango
-----
Consider `cpptango@9.4.2` and `pytango@9.4.2` for now.
