#! /bin/bash

set -e

FIXTURE_PATH="spec/fixtures/wordless"
WORDLESS_REPO="git://github.com/welaika/wordless.git"
WORDLESS_PREFERENCES="wordless/theme_builder/vanilla_theme/config/initializers/wordless_preferences.php"

rm -rf $FIXTURE_PATH

git clone --branch=master $WORDLESS_REPO $FIXTURE_PATH && cd $FIXTURE_PATH
cp -f ../wordless_preferences.php $WORDLESS_PREFERENCES
perl -p -i -e "s|<RUBY_PATH>|$(which ruby)|" $WORDLESS_PREFERENCES
perl -p -i -e "s|<COMPASS_PATH>|$(which compass)|" $WORDLESS_PREFERENCES

echo "== BEGIN: wordless_preferences.php =="
cat $WORDLESS_PREFERENCES
echo "== END: wordless_preferences.php =="

git config user.name "Wordless Tester"
git config user.email "tester@wordless.com"
git commit -am "updated ruby and compass path"

echo "[OK!]"
