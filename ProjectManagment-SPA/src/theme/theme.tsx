import { createTheme } from "@mui/material";
import ComponentsOverrides from "./overrides";

const theme = createTheme({
  breakpoints: {
    values: {
      xs: 0,
      sm: 768,
      md: 1024,
      lg: 1266,
      xl: 1536,
    },
  },
  direction: "rtl",
  mixins: {
    toolbar: {
      minHeight: 60,
      paddingTop: 8,
      paddingBottom: 8,
    },
  },
  palette: {
    primary: {
      main: "#1760a5",
      lighter: "#e6f7ff",

      // light: "skyblue",
    },
    secondary: {
      main: "#15c630",
    },
    otherColor: {
      main: "#999",
    },
  },
});

theme.components = ComponentsOverrides(theme);

export default theme;
