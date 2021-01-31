module.exports = {
  purge: {
    enabled: process.env.RAILS_ENV === 'production',
    content: [
      './app/snowpacker/**/*.jsx',
      './app/assets/javascripts/**/*.js',
      './app/views/**/*.html.erb',
      './app/components/**/*.rb',
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
