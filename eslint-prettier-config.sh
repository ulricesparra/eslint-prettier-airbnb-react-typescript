#!/bin/bash

# ----------------------
# Color Variables
# ----------------------
RED="\033[0;31m"
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

# --------------------------------------
# Prompts for configuration preferences
# --------------------------------------
# Checks for existing eslintrc files
if [ -f ".eslintrc.js" -o -f ".eslintrc.yaml" -o -f ".eslintrc.yml" -o -f ".eslintrc.json" -o -f ".eslintrc" ]; then
  echo -e "${RED}Existing ESLint config file(s) found:${NC}"
  ls -a .eslint* | xargs -n 1 basename
  echo
  echo -e "${RED}CAUTION:${NC} there is loading priority when more than one config file is present: https://eslint.org/docs/user-guide/configuring#configuration-file-formats"
  echo
  read -p  "Write .eslintrc (Y/n)? "
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${YELLOW}>>>>> Skipping ESLint config${NC}"
    skip_eslint_setup="true"
  fi
fi

# ----------------------
# Perform Configuration
# ----------------------
echo
echo -e "${GREEN}Configuring your development environment... ${NC}"

echo
echo -e "1/3 ${LCYAN}ESLint & Prettier Installation... ${NC}"
echo
npm i -D eslint prettier eslint-config-airbnb-typescript-prettier


if [ "$skip_eslint_setup" == "true" ]; then
  break
else
  echo
  echo -e "2/3 ${YELLOW}Building your .eslintrc file...${NC}"
  > ".eslintrc" # truncates existing file (or creates empty)

  echo '{
  "extends": ["airbnb-typescript-prettier"],
  "rules": {
    "no-console": "off",
    "no-nested-ternary": "off",
    "@typescript-eslint/explicit-module-boundary-types": "off",
    "@typescript-eslint/no-unused-vars": "off",
    "no-useless-constructor": "off",
    "@typescript-eslint/no-useless-constructor": ["error"]
  }
}' >> .eslintrc
fi

if [ "$skip_prettier_setup" == "true" ]; then
  break
else
  echo -e "3/3 ${YELLOW}Building your .prettierrc file... ${NC}"
  > .prettierrc # truncates existing file (or creates empty)

  echo '{
  "printWidth": '100',
  "singleQuote": true,
  "trailingComma": "'es5'"
}' >> .prettierrc
fi

echo
echo -e "${GREEN}Finished setting up!${NC}"
echo
