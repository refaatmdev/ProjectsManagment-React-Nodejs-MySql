import { Box, CssBaseline, Toolbar } from "@mui/material";
import React, { useEffect, useState } from "react";
import Footer from "../components/Footer";
import Navbar from "../components/Navbar";
import Sidebar from "../components/Sidebar";
import { Outlet, useLocation, useMatches } from "react-router-dom";
import { sideBarWidth } from "./config";
import { useAppDispatch, useAppSelector } from "../store/hooks";
import { getProjects } from "../store/projectsSlice";
import {
  getProjectsFromLocalStorage,
  setProjectsToLocalStorage,
} from "../store/services/Projects.services";
import Breadcrumbs from "./Breadcrumbs";
import { getEmployees } from "../store/employeesSlice";

const MainLayout = () => {
  const dispatch = useAppDispatch();
  const [mobileOpen, setMobileOpen] = useState(false);
  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  useEffect(() => {
    console.log("mainLayout dispatch");
    dispatch(getProjects({}));
    dispatch(getEmployees({}));
  }, [dispatch]);

  return (
    <Box sx={{ display: "flex" }}>
      <CssBaseline />
      <Navbar handleDrawerToggle={handleDrawerToggle} />

      <Box
        component="nav"
        sx={{ width: { sm: sideBarWidth }, flexShrink: { sm: 0 } }}
      >
        <Sidebar
          mobileOpen={mobileOpen}
          handleDrawerToggle={handleDrawerToggle}
        />
      </Box>
      <Box
        component="main"
        sx={{
          flexGrow: 1,
          p: 3,
          width: { sm: `calc(100% - ${sideBarWidth}px)` },
        }}
      >
        <Box
          sx={{
            position: "relative",
            minHeight: "calc(100vh - 50px)",
            display: "flex",
            flexDirection: "column",
          }}
        >
          <Toolbar />
          <Breadcrumbs />
          <Outlet />
          <Footer />
        </Box>
      </Box>
    </Box>
  );
};

export default MainLayout;
