module.exports = {
  'parser': 'babel-eslint',
  'env': {
    'browser': true,
    'es6': true,
  },
  'extends': [
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'google',
  ],
  'globals': {
    'Atomics': 'readonly',
    'SharedArrayBuffer': 'readonly',
  },
  'parserOptions': {
    'ecmaFeatures': {
      'jsx': true,
    },
    'ecmaVersion': 2018,
    'sourceType': 'module',
  },
  'plugins': [
    'autofix',
    'react',
    'react-hooks',
    'sort-imports-es6-autofix',
    'sort-keys-fix'
  ],
  'rules': {
    'require-jsdoc': 0,
    'react/prop-types': 0,
    'react/no-unescaped-entities': 0,
    'max-len': 0,
    'guard-for-in': 0,
    'react/jsx-no-target-blank': 0,
    'prefer-promise-reject-errors': 0,
    'sort-imports-es6-autofix/sort-imports-es6': [2, {
      'ignoreCase': false,
      'ignoreMemberSort': false,
      'memberSyntaxSortOrder': ['none', 'all', 'multiple', 'single']
    }],
    'sort-keys-fix/sort-keys-fix': 'warn',
    "react/jsx-uses-react": "off",
    "react/react-in-jsx-scope": "off"
  },
  settings: {
    react: {
      version: "detect"
    }
  }
};
