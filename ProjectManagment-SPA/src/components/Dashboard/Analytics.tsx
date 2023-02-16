import { FallOutlined } from "@ant-design/icons";
import { Box, Chip, Grid, Stack, Typography } from "@mui/material";
import React from "react";
import MainCard from "../customizeComponents/MainCard";

const Analytics = () => {
  return (
    <MainCard border contentSX={{ p: 2.25 }}>
      <Stack spacing={0.5}>
        <Typography variant="h6" color="textSecondary">
          סך הכל פרוייקטים
        </Typography>
        <Grid container alignItems="center">
          <Grid item>
            <Typography variant="h5" color="inherit">
              {"30,000"}
            </Typography>
          </Grid>

          <Grid item>
            <Chip
              variant="outlined"
              color={"warning"}
              icon={
                <>
                  {/* {!isLoss && <RiseOutlined style={{ fontSize: '0.75rem', color: 'inherit' }} />} */}
                  {true && (
                    <FallOutlined
                      style={{ fontSize: "0.75rem", color: "inherit" }}
                    />
                  )}
                </>
              }
              label={`${10}%`}
              sx={{ ml: 1.25, pl: 1 }}
              size="small"
            />
          </Grid>
        </Grid>
      </Stack>
      <Box sx={{ pt: 2.25 }}>
        <Typography variant="caption" color="textSecondary">
          You made an extra{" "}
          <Typography
            component="span"
            variant="caption"
            sx={{ color: `primary.main` }}
          >
            {2424}
          </Typography>{" "}
          this year
        </Typography>
      </Box>
    </MainCard>
  );
};

export default Analytics;
