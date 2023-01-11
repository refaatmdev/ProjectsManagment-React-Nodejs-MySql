import { EditOutlined, PhoneOutlined } from "@mui/icons-material";
import {
  Box,
  Chip,
  Divider,
  Grid,
  IconButton,
  List,
  ListItem,
  ListItemIcon,
  ListItemSecondaryAction,
  Stack,
  Typography,
} from "@mui/material";
import { grey } from "@mui/material/colors";
import React, { useCallback, useState } from "react";
import MainCard from "../customizeComponents/MainCard";
import dayjs from "dayjs";
import { IProject } from "../../_interfaces/project.interface";
import CurrencyFormat from "react-currency-format";
import PersonIcon from "@mui/icons-material/Person";
import LocationCityIcon from "@mui/icons-material/LocationCity";
import PaidIcon from "@mui/icons-material/Paid";
import QuotationAction from "./QuotationAction";
interface IProps {
  project: IProject;
}
const ProjectTap = ({ project }: IProps) => {
  const [show, setShow] = useState(false);
  const handleClose = useCallback(() => {
    setShow(false);
  }, [show]);
  return (
    <>
      <MainCard>
        <Grid container spacing={3}>
          <Grid item xs={12}>
            <Stack
              direction="row"
              spacing={2}
              justifyContent="space-between"
              alignItems="center"
              sx={{ pb: 2 }}
            >
              <Typography variant={"subtitle2"}>
                עדכון / הוספת הסכם/ סכום
              </Typography>
              <IconButton
                color="primary"
                size="large"
                onClick={() => setShow(true)}
              >
                <EditOutlined />
              </IconButton>
            </Stack>
            <Stack spacing={2.5} alignItems="center">
              {/* <Avatar alt="Avatar 1" size="xl"  /> */}
              <Stack spacing={0.5} alignItems="center">
                <Typography variant="h5">{project.projectName}</Typography>
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
                  {dayjs(project.createdAt).format("MM-YYYY")}
                </Typography>
                <Typography>תאריך התחלה</Typography>
              </Stack>
              <Divider orientation="vertical" flexItem />
              <Stack spacing={0.5} alignItems="center">
                <Typography
                  sx={{ typography: { sm: "body1", xs: "body2" } }}
                  color={grey[800]}
                >
                  <CurrencyFormat
                    value={project.quotation != null ? project.quotation : 0}
                    displayType={"text"}
                    thousandSeparator={true}
                    prefix={"₪"}
                  />
                </Typography>
                <Typography>סכום</Typography>
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
                  <PersonIcon />
                </ListItemIcon>
                <ListItemSecondaryAction>
                  <Typography align="right" color={grey[800]}>
                    {project.clientFullName}
                  </Typography>
                </ListItemSecondaryAction>
              </ListItem>
              <ListItem>
                <ListItemIcon>
                  <PhoneOutlined />
                </ListItemIcon>
                <ListItemSecondaryAction>
                  <Typography align="right" color={grey[800]}>
                    {project.clientPhone}
                  </Typography>
                </ListItemSecondaryAction>
              </ListItem>
              <ListItem>
                <ListItemIcon>
                  <LocationCityIcon />
                </ListItemIcon>
                <ListItemSecondaryAction>
                  <Typography align="right" color={grey[800]}>
                    {project.location}
                  </Typography>
                </ListItemSecondaryAction>
              </ListItem>
              <ListItem>
                <ListItemIcon>
                  <PaidIcon />
                </ListItemIcon>
                <ListItemSecondaryAction>
                  <Typography align="right" color={grey[800]}>
                    {project.paid}
                  </Typography>
                </ListItemSecondaryAction>
              </ListItem>
            </List>
          </Grid>
        </Grid>
      </MainCard>
      {project && (
        <QuotationAction show={show} handelClose={handleClose} data={project} />
      )}
    </>
  );
};

export default ProjectTap;
