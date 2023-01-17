import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import { RTL } from "./theme/RTL";
import { ThemeProvider } from "@mui/material/styles";
import theme from "./theme/theme";
import { Provider } from "react-redux";
import { store } from "./store/store";

import SnakBar from "./components/SnakBar";

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);
root.render(
  // <React.StrictMode>
  <Provider store={store}>
    <RTL>
      <ThemeProvider theme={theme}>
        <SnakBar />
        <App />
        {/* {element} */}
      </ThemeProvider>
    </RTL>
  </Provider>
  // </React.StrictMode>
);
