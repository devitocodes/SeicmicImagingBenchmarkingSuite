reveal-md README.md --static ../SIBS_gh-pages
pushd ../sibs-pages
cp -a ../SIBS_gh-pages/* .
git add --all
git commit -m "Update"
git push origin gh-pages
popd -
