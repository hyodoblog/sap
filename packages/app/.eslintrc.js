module.exports = {
  root: true,
  env: {
    browser: true,
    node: true,
  },
  extends: [
    '@nuxtjs/eslint-config-typescript',
    'eslint:recommended',
    'prettier',
    'plugin:prettier/recommended',
    'plugin:nuxt/recommended',
  ],
  plugins: ['prettier'],
  // add your custom rules here
  rules: {
    semi: [2, 'never'],
    'no-console': 'off',
    'vue/max-attributes-per-line': 'off',
    'prettier/prettier': ['error', { semi: false }],
    'no-new': 'off',
    'no-undef': 'off',
    'no-unused-vars': 'off',
    camelcase: [
      0,
      {
        properties: 'always',
      },
    ],
  },
}
