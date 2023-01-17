import React, { ReactNode } from "react";

import { Link } from "react-router-dom";

// material-ui
import { Grid, Stack, Typography } from "@mui/material";
import AuthWrapper from "../../components/Auth/AuthWrapper";
import LoginForm from "../../components/Auth/LoginForm";

// project import

// ================================|| LOGIN ||================================ //

const Login = () => {
  return (
    <AuthWrapper>
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <Stack
            direction="row"
            justifyContent="space-between"
            alignItems="baseline"
            sx={{ mb: { xs: -0.5, sm: 0.5 } }}
          >
            <Typography variant="h6">התחברות</Typography>
            <Typography
              component={Link}
              to={true ? "/auth/register" : "/register"}
              variant="body1"
              sx={{ textDecoration: "none" }}
              color="primary"
            >
              אין לך חשבון ?
            </Typography>
          </Stack>
        </Grid>
        <Grid item xs={12}>
          <LoginForm />
        </Grid>
      </Grid>
    </AuthWrapper>
  );
};

export default Login;
