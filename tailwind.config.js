module.exports = {
  purge: {
    enabled: process.env.RAILS_ENV === 'production',
    content: [
      './app/javascript/**/*.js',
      './app/javascript/**/*.jsx',
      './app/assets/javascripts/**/*.js',
      './app/views/**/*.html.erb',
      './app/components/**/*.rb',
      './app/components/**/*.html.erb',
      './app/helpers/**/*.rb',
    ],
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
  corePlugins: {
    preflight: false
  }
}
