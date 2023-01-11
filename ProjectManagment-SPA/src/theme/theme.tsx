import { createTheme } from "@mui/material";
import ComponentsOverrides from "./overrides";
import { PaletteColorOptions } from "@mui/material/styles";
import { PalettesProps } from "@ant-design/colors";
import { blue } from "@ant-design/colors";

let greyPrimary = [
  "#ffffff",
  "#fafafa",
  "#f5f5f5",
  "#f0f0f0",
  "#d9d9d9",
  "#bfbfbf",
  "#8c8c8c",
  "#595959",
  "#262626",
  "#141414",
  "#000000",
];
let greyAscent = ["#fafafa", "#bfbfbf", "#434343", "#1f1f1f"];
let greyConstant = ["#fafafb", "#e6ebf1"];
const grey = [...greyPrimary, ...greyAscent, ...greyConstant];

// const greyColors: PaletteColorOptions = {
//   0: grey[0],
//   50: grey[1],
//   100: grey[2],
//   200: grey[3],
//   300: grey[4],
//   400: grey[5],
//   500: grey[6],
//   600: grey[7],
//   700: grey[8],
//   800: grey[9],
//   900: grey[10],
//   A50: grey[15],
//   A100: grey[11],
//   A200: grey[12],
//   A400: grey[13],
//   A700: grey[14],
//   A800: grey[16],
// };
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
      main: "#096dd9",
      lighter: "#e6f7ff",
      light: "#69c0ff",

      // light: "skyblue",
    },
    secondary: {
      main: "#8c8c8c",
      lighter: "#f5f5f5",
      light: "#d9d9d9",
    },
    otherColor: {
      main: "#999",
    },
    background: {
      default: "#FAFAFB",
    },
  },
});

theme.components = ComponentsOverrides(theme);

export default theme;
