const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'scrollbar-track': '#404040',
        'scrollbar-thumb': '#606060',
        'scrollbar-thumb-hover': '#6b7280',
      },
      maxHeight: {
        '640': '640px',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    function ({ addUtilities, theme }) {
      addUtilities({
        '.scrollbar-thin': {
          '&::-webkit-scrollbar': {
            width: '6px',
          },
          '&::-webkit-scrollbar-track': {
            backgroundColor: theme('colors.scrollbar-track'),
          },
          '&::-webkit-scrollbar-thumb': {
            backgroundColor: theme('colors.scrollbar-thumb'),
            borderRadius: '3px',
          },
          '&::-webkit-scrollbar-thumb:hover': {
            backgroundColor: theme('colors.scrollbar-thumb-hover'),
          },
          'scrollbar-width': 'thin',
          'scrollbar-color': theme('colors.scrollbar-thumb') + ' ' + theme('colors.scrollbar-track'),
        },
        '.scrollbar-none': {
          '-ms-overflow-style': 'none',
          'scrollbar-width': 'none',
          '&::-webkit-scrollbar': {
            display: 'none',
          },
        },
      });
    },
  ],
};
