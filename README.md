# MLZ brew formulae collection
This tap contains following packages:
 - cpptango@9.5 [v9.5.0](https://gitlab.com/tango-controls/cppTango) - [homepage](https://www.tango-controls.org)
 - cpptango [v10.0.0](https://gitlab.com/tango-controls/cppTango) - [homepage](https://www.tango-controls.org)
 - gr [v0.73.10](https://github.com/sciapp/gr) - [homepage](https://gr-framework.org)
 - hdf4 [v4.3.0](https://github.com/HDFGroup/hdf4) - [homepage](https://www.hdfgroup.org/solutions/hdf4)
 - musrfit [v1.9.6](https://bitbucket.org/muonspin/musrfit/src/root6/) - [homepage](http://lmu.web.psi.ch/musrfit/user/html/index.html)
 - nexus-format [v4.4.3](https://github.com/nexusformat/code) - [homepage](https://www.nexusformat.org)
 - nicos-pyctl [v1.3.0](https://github.com/mlz-ictrl/nicos-pyctl) - [homepage](https://github.com/mlz-ictrl/nicos-pyctl)
 - numpy@1.26 [v1.26.4](https://github.com/numpy/numpy) - [homepage](https://numpy.org/)
 - pytango@9.5 [v9.5.1](https://gitlab.com/tango-controls/pytango) - [homepage](https://www.tango-controls.org)
 - pytango [v10.0.0](https://gitlab.com/tango-controls/pytango) - [homepage](https://www.tango-controls.org)
 - python-gr [v1.27.0](https://github.com/sciapp/python-gr) - [homepage](https://gr-framework.org)
 - python-psutil [v5.9.8](https://github.com/giampaolo/psutil) - [homepage](https://github.com/giampaolo/psutil)
 - python-rsa [v4.9](https://github.com/sybrenstuvel/python-rsa) - [homepage](https://stuvel.eu/rsa)
 - python-toml [v0.10.2](https://github.com/uiri/toml) - [homepage](https://github.com/uiri/toml)
 - python-vcversioner [v2.16.0.0](https://github.com/habnabit/vcversioner)
 - tangoidl [v6.0.2](https://gitlab.com/tango-controls/tango-idl) - [homepage](https://www.tango-controls.org)

# Installation
```bash
brew tap mlz/packages https://forge.frm2.tum.de/review/mlz/packages/homebrew
brew install [package]
```

# Notes

Gr
--
Gr framework is built against qt@6, however if qt@5 is also installed in your
brew, be sure it is not linked, otherwise compilation will fail.
```bash
brew unlink qt@5
```
