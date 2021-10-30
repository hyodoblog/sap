module.exports = {
  root: true,
  env: {
    browser: true,
    node: true
  },
  extends: [
    '@nuxtjs',
    '@nuxtjs/eslint-config-typescript',
    'plugin:prettier/recommended',
    'plugin:nuxt/recommended',
    'plugin:import/errors'
  ],
  plugins: ['vue', '@typescript-eslint', 'import'],
  rules: {
    // import
    'import/named': 'off',
    'import/no-unresolved': 'off',
    'sort-imports': 0,

    // prettier
    'no-console': [
      'error',
      {
        allow: ['warn', 'error']
      }
    ],

    // vue
    'vue/html-closing-bracket-newline': [
      'error',
      {
        singleline: 'never',
        multiline: 'always'
      }
    ],
    'vue/html-self-closing': [
      'error',
      {
        html: {
          void: 'always'
        }
      }
    ],
    'vue/no-v-html': 'off',
    'vue/attributes-order': 'error',
    'vue/v-slot-style': 'error'
  }
}
