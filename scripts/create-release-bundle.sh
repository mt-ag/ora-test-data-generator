curr_dir=${PWD##*/}
if [ "$curr_dir" == "scripts" ]; then
  echo "Please run this script from the main directory"
  exit 1
fi

rm ora-test-data-generator.zip || true
rm -rf _ora-test-data-generator || true

mkdir _ora-test-data-generator

cp -r src/* _ora-test-data-generator
cp scripts/_install.sql _ora-test-data-generator
cp scripts/_uninstall.sql _ora-test-data-generator
zip -r ora-test-data-generator.zip _ora-test-data-generator

rm -rf _ora-test-data-generator

echo "Done"
