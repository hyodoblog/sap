module.exports = {
  root: true,
  env: {
    browser: true,
    node: true,
  },
  extends: ['@nuxtjs', '@nuxtjs/eslint-config-typescript', 'plugin:prettier/recommended', 'plugin:nuxt/recommended'],
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
        allow: ['warn', 'error', 'info', 'table'],
      },
    ],

    'import/no-named-as-default-member': 0,

    // vue
    'vue/first-attribute-linebreak': 0,
    'vue/multi-word-component-names': 0,
    'vue/no-reserved-props': 0,
    'vue/html-closing-bracket-newline': [
      'error',
      {
        singleline: 'never',
        multiline: 'always',
      },
    ],
    'vue/html-self-closing': [
      'error',
      {
        html: {
          void: 'always',
        },
      },
    ],
    'vue/no-v-html': 'off',
    'vue/attributes-order': 'error',
    'vue/v-slot-style': 'error',
  },
}
