import { Box, Button, Grid, Stack, Typography } from "@mui/material";
import React from "react";
import MainCard from "../../components/customizeComponents/MainCard";
import Analytics from "../../components/Dashboard/Analytics";
import SalaryChar from "../../components/Dashboard/SalaryChar";

const Dashboard = () => {
  return (
    <Grid container rowSpacing={4.5} columnSpacing={2.75}>
      <Grid item xs={12} sm={6} md={4} lg={3}>
        <Analytics />
      </Grid>
      <Grid item xs={12} sm={6} md={4} lg={3}>
        {" "}
        <Analytics />
      </Grid>
      <Grid item xs={12} sm={6} md={4} lg={3}>
        {" "}
        <Analytics />
      </Grid>
      <Grid
        item
        md={8}
        sx={{ display: { sm: "none", md: "block", lg: "none" } }}
      />

      <Grid item xs={12} md={7} lg={8}>
        <Grid container alignItems="center" justifyContent="space-between">
          <Grid item>
            <Typography variant="h5">Unique Visitor</Typography>
          </Grid>
          <Grid item>
            <Stack direction="row" alignItems="center" spacing={0}>
              <Button
                size="small"
                // onClick={() => setSlot('month')}
                // color={slot === 'month' ? 'primary' : 'secondary'}
                // variant={slot === 'month' ? 'outlined' : 'text'}
              >
                Month
              </Button>
              <Button
                size="small"
                // onClick={() => setSlot('week')}
                // color={slot === 'week' ? 'primary' : 'secondary'}
                // variant={slot === 'week' ? 'outlined' : 'text'}
              >
                Week
              </Button>
            </Stack>
          </Grid>
        </Grid>
        <MainCard content={false} sx={{ mt: 1.5 }}>
          <Box sx={{ pt: 1, pr: 2 }}>
            <SalaryChar />
          </Box>
        </MainCard>
      </Grid>
    </Grid>
  );
};

export default Dashboard;
