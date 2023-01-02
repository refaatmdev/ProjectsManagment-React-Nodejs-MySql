import { Link, Typography } from "@mui/material";
import React from "react";
import Breadcrumbs from "@mui/material/Breadcrumbs";

import { useLocation, useNavigate } from "react-router-dom";
import { useAppSelector } from "../store/hooks";

const BreadcrumbsApp = () => {
  const { employee } = useAppSelector((state) => state.employee);
  const { project } = useAppSelector((state) => state.projects);
  let navigate = useNavigate();
  let location = useLocation();
  let currentRoutes: any[] = [];
  currentRoutes = location.pathname !== "/" ? location.pathname.split("/") : [];

  const translateRoutToHebswitch = (route: string) => {
    switch (route) {
      case "Employees":
        return "עובדים";
      case "Projects":
        return "פרוייקטים";
      default:
        return null;
    }
  };

  const covertIdParames = (currentRoutes: any, index: number, route: any) => {
    if (
      currentRoutes[0] === "Employees" &&
      index === currentRoutes.length - 1
    ) {
      return employee && employee.firstName + " " + employee.lastName;
    } else if (
      currentRoutes[0] === "Projects" &&
      index === currentRoutes.length - 1
    ) {
      return project && project.projectName;
    }
  };

  if (currentRoutes.length > 0) {
    currentRoutes.shift();
    return (
      <Breadcrumbs
        separator="›"
        aria-label="breadcrumb"
        style={{ marginBottom: 15 }}
      >
        <Link
          color="inherit"
          onClick={() => navigate("/")}
          style={{ cursor: "pointer" }}
        >
          דף הבית
        </Link>
        {currentRoutes.length === 1 ? (
          <Typography color="textPrimary">
            {translateRoutToHebswitch(currentRoutes[0])}
          </Typography>
        ) : (
          currentRoutes.map((route, index) => {
            return index !== currentRoutes.length - 1 ? (
              <Link
                key={index}
                color="inherit"
                style={{ cursor: "pointer" }}
                onClick={() => {
                  navigate(route);
                }}
              >
                {translateRoutToHebswitch(route)}
              </Link>
            ) : (
              <Typography key={index} color="textPrimary">
                {covertIdParames(currentRoutes, index, route)}{" "}
              </Typography>
            );
          })
        )}
      </Breadcrumbs>
    );
  } else return <></>;
};

export default BreadcrumbsApp;
