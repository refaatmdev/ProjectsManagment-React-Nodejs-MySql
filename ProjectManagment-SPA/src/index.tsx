import React, { ReactNode } from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import { RTL } from "./theme/RTL";
import { ThemeProvider } from "@mui/material/styles";
import theme from "./theme/theme";
import { Provider } from "react-redux";
import { store } from "./store/store";
import {
  RouterProvider,
  createBrowserRouter,
  RouteObject,
} from "react-router-dom";
import Employees from "./pages/Employees";
import Employee from "./pages/Employees/Employee";
import ErrorPage from "./pages/ErrorPage";
import SnakBar from "./components/SnakBar";
import Projects from "./pages/Projects";
import Project from "./pages/Projects/Project";
import Reports from "./pages/Reports";
import Salaries from "./pages/Salaries";

let routes: RouteObject[] = [
  {
    path: "/",
    element: <App />,
    errorElement: <ErrorPage />,
    children: [
      { index: true, element: <Employees /> },
      { path: "Employees", element: <Employees /> },
      {
        path: "Employees/:id",
        element: <Employee />,
      },
    ],
  },
];

export const router = createBrowserRouter([
  {
    path: "/",
    element: <App />,
    errorElement: <ErrorPage />,
    children: [
      { index: true, element: <Employees /> },
      { path: "Employees", element: <Employees /> },
      {
        path: "Employees/:id",
        element: <Employee />,
      },
      { path: "Projects", element: <Projects /> },
      { path: "Projects/:id", element: <Project /> },
      { path: "Reports", element: <Reports /> },
      { path: "Salaries", element: <Salaries /> },
    ],
  },
]);

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);
root.render(
  // <React.StrictMode>
  <Provider store={store}>
    <RTL>
      <ThemeProvider theme={theme}>
        <SnakBar />
        <RouterProvider router={router} />
        {/* {element} */}
      </ThemeProvider>
    </RTL>
  </Provider>
  // </React.StrictMode>
);
