const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*",
    "./app/components/**/*",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
      colors: {
        "spotify-green": "#1ed760",
        "spotify-green2": "#1db954",
        "spotify-black": "#191414",
        "spotify-white": "#fafafa",
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
  ],
};
