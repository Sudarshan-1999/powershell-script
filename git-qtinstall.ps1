git clone git://code.qt.io/qt/qt5.git
cd qt5
git checkout 5.12.2
perl init-repository
mkdir qt5-build
cd qt5-build
..\\qt5\configure -developer-build -opensource -nomake examples -nomake tests -confirm-license
jom