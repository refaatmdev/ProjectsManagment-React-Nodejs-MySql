import * as React from "react";
import { lazy, Suspense } from "react";
import AuthGuard from "./../routes/AuthGuard";
import Loader from "./../routes/Loader";
import GuestGuard from "./../routes/GuestGuard";
import { createBrowserRouter } from "react-router-dom";
import MainLayout from "../Layout/MainLayout";
const Dashboard = lazy(() => import("./../pages/Dashboard"));
const ErrorPage = lazy(() => import("./../pages/ErrorPage"));
const Employees = lazy(() => import("./../pages/Employees"));
const Employee = lazy(() => import("./../pages/Employees/Employee"));
const Projects = lazy(() => import("./../pages/Projects"));
const Project = lazy(() => import("./../pages/Projects/Project"));
const Reports = lazy(() => import("./../pages/Reports"));
const Salaries = lazy(() => import("./../pages/Salaries"));
const Login = lazy(() => import("./../pages/Auth/Login"));

const router = createBrowserRouter([
  {
    path: "/",
    element: (
      <AuthGuard>
        <MainLayout />
      </AuthGuard>
    ),
    errorElement: <ErrorPage />,
    children: [
      {
        index: true,
        element: (
          <Suspense fallback={<Loader />}>
            <Projects />{" "}
          </Suspense>
        ),
      },
      {
        path: "Employees",
        element: (
          <Suspense fallback={<Loader />}>
            <Employees />
          </Suspense>
        ),
      },
      {
        path: "Employees/:id",
        element: (
          <Suspense fallback={<Loader />}>
            <Employee />
          </Suspense>
        ),
      },
      {
        path: "Projects",
        element: (
          <Suspense fallback={<Loader />}>
            <Projects />{" "}
          </Suspense>
        ),
      },
      {
        path: "Projects/:id",
        element: (
          <Suspense fallback={<Loader />}>
            <Project />
          </Suspense>
        ),
      },
      {
        path: "Reports",
        element: (
          <Suspense fallback={<Loader />}>
            <Reports />{" "}
          </Suspense>
        ),
      },
      {
        path: "Salaries",
        element: (
          <Suspense fallback={<Loader />}>
            <Salaries />{" "}
          </Suspense>
        ),
      },
    ],
  },
  {
    path: "/auth/",
    errorElement: <ErrorPage />,
    children: [
      {
        path: "Login",
        element: (
          <Suspense fallback={<Loader />}>
            <GuestGuard>
              <Login />
            </GuestGuard>
          </Suspense>
        ),
      },
    ],
  },
]);

export default router;
