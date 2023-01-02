import { PaletteColorOptions, ThemeOptions } from "@mui/material/styles";

declare module "@mui/material/styles" {
  interface PaletteOptions {
    otherColor?: PaletteColorOptions;
  }
  interface Palette {
    otherColor?: PaletteColor;
  }
  interface SimplePaletteColorOptions {
    darker?: string;
    lighter?: string;
  }
  interface PaletteColor {
    darker?: string;
    lighter?: string;
  }
}
