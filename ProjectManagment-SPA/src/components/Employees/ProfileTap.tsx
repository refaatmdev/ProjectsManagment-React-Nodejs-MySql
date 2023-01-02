import { PhoneOutlined } from "@mui/icons-material";
import {
  Box,
  Chip,
  Divider,
  Grid,
  List,
  ListItem,
  ListItemIcon,
  ListItemSecondaryAction,
  Stack,
  Typography,
} from "@mui/material";
import { grey } from "@mui/material/colors";
import React from "react";
import MainCard from "../customizeComponents/MainCard";
import AccountBalanceIcon from "@mui/icons-material/AccountBalance";
import { IEmployee } from "../../_interfaces/emplyee.interface";
import dayjs from "dayjs";

interface IProps {
  employee: IEmployee;
}
const ProfileTap = ({ employee }: IProps) => {
  return (
    <MainCard>
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <Stack
            direction="row"
            spacing={2}
            justifyContent="space-between"
            sx={{ pb: 2 }}
          >
            <Box>סטטוס</Box>
            <Chip
              label={employee.isActive == 1 ? "פעיל" : "לא פעיל"}
              size="small"
              color={employee.isActive == 1 ? "success" : "error"}
            />
          </Stack>
          <Stack spacing={2.5} alignItems="center">
            {/* <Avatar alt="Avatar 1" size="xl"  /> */}
            <Stack spacing={0.5} alignItems="center">
              <Typography variant="h5">
                {employee.firstName} {employee.lastName}
              </Typography>
              {/* <Typography color="secondary">
              Project Manager
            </Typography> */}
            </Stack>
          </Stack>
        </Grid>
        <Grid item xs={12}>
          <Divider />
        </Grid>
        <Grid item xs={12}>
          <Stack
            direction="row"
            justifyContent="space-around"
            alignItems="center"
          >
            <Stack spacing={0.5} alignItems="center">
              <Typography
                sx={{ typography: { sm: "body1", xs: "body2" } }}
                color={grey[800]}
              >
                {dayjs(employee.createdAt).format("MM-YYYY")}
              </Typography>
              <Typography>תאריך התחלה</Typography>
            </Stack>
            <Divider orientation="vertical" flexItem />
            <Stack spacing={0.5} alignItems="center">
              <Typography
                sx={{ typography: { sm: "body1", xs: "body2" } }}
                color={grey[800]}
              >
                {employee.dailyWage}
              </Typography>
              <Typography>שכר יומי</Typography>
            </Stack>
          </Stack>
        </Grid>
        <Grid item xs={12}>
          <Divider />
        </Grid>
        <Grid item xs={12}>
          <List
            component="nav"
            aria-label="main mailbox folders"
            sx={{
              py: 0,
              "& .MuiListItem-root": { p: 0, py: 1 },
            }}
          >
            <ListItem>
              <ListItemIcon>
                <PhoneOutlined />
              </ListItemIcon>
              <ListItemSecondaryAction>
                <Typography align="right" color={grey[800]}>
                  {employee.phone}
                </Typography>
              </ListItemSecondaryAction>
            </ListItem>
            <ListItem>
              <ListItemIcon>
                <AccountBalanceIcon />
              </ListItemIcon>
              <ListItemSecondaryAction>
                <Typography align="right" color={grey[800]}>
                  {employee.bankAccount}
                </Typography>
              </ListItemSecondaryAction>
            </ListItem>
            <ListItem>
              <ListItemIcon>
                <AccountBalanceIcon />
              </ListItemIcon>
              <ListItemSecondaryAction>
                <Typography align="right" color={grey[800]}>
                  {employee.bankAccount}
                </Typography>
              </ListItemSecondaryAction>
            </ListItem>
          </List>
        </Grid>
      </Grid>
    </MainCard>
  );
};

export default ProfileTap;
