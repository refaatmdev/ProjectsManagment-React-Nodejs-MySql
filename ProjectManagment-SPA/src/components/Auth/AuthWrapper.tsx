import React, { ReactNode } from "react";
import { alpha, Theme, useTheme } from "@mui/material/styles";

// material-ui
import { Box, Grid } from "@mui/material";

// project import
// import AuthFooter from "components/cards/AuthFooter";
// import Logo from "components/logo";

// assets
import AuthBackground from "../../assets/images/auth/AuthBackground";
import MainCard from "../customizeComponents/MainCard";

interface Props {
  children: ReactNode;
}

// ==============================|| AUTHENTICATION - WRAPPER ||============================== //

const AuthWrapper = ({ children }: Props) => {
  const theme = useTheme();

  return (
    <Box sx={{ minHeight: "100vh" }}>
      <AuthBackground />
      <Grid
        container
        direction="column"
        justifyContent="flex-end"
        sx={{
          minHeight: "100vh",
        }}
      >
        <Grid item xs={12} sx={{ ml: 3, mt: 3 }}>
          {/* <Logo /> */} Logo
        </Grid>
        <Grid item xs={12}>
          <Grid
            item
            xs={12}
            container
            justifyContent="center"
            alignItems="center"
            sx={{
              minHeight: {
                xs: "calc(100vh - 210px)",
                sm: "calc(100vh - 134px)",
                md: "calc(100vh - 112px)",
              },
            }}
          >
            <Grid item>
              <MainCard
                sx={{
                  maxWidth: { xs: 400, lg: 475 },
                  margin: { xs: 2.5, md: 3 },
                  "& > *": {
                    flexGrow: 1,
                    flexBasis: "50%",
                  },
                  padding: "32px",
                }}
                content={false}
                border={false}
                boxShadow
                shadow={`0px 1px 4px ${alpha(theme.palette.grey[900], 0.08)}`}
              >
                {children}{" "}
              </MainCard>
            </Grid>
          </Grid>
        </Grid>
      </Grid>
    </Box>
  );
};

export default AuthWrapper;
