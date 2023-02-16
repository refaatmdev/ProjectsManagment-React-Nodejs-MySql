import { styled } from "@mui/system";
import {
  AppBar,
  Box,
  IconButton,
  Toolbar,
  Tooltip,
  Typography,
} from "@mui/material";
import React, { useState } from "react";
import { Plumbing } from "@mui/icons-material";
import MenuIcon from "@mui/icons-material/Menu";
import { grey } from "@mui/material/colors";
import { useNavigate } from "react-router-dom";
import { useAppDispatch } from "../store/hooks";
import { logout } from "../store/authSlice";
import LogoutIcon from "@mui/icons-material/Logout";
const StyledToolBar = styled(Toolbar)(({ theme }) => ({
  display: "flex",
  justifyContent: "space-between",
}));

const ActionsBar = styled(Box)(({ theme }) => ({
  display: "flex",
  alignItems: "center",
  gap: "20px",
}));

interface INavBarProps {
  handleDrawerToggle: () => void;
}
const Navbar = ({ handleDrawerToggle }: INavBarProps) => {
  const navigate = useNavigate();
  const dispatch = useAppDispatch();

  const logoutUser = async () => {
    await dispatch(logout());
    navigate("/auth/login");
  };

  return (
    <AppBar
      position="fixed"
      elevation={0}
      sx={{ zIndex: (theme) => theme.zIndex.drawer + 1 }}
    >
      <StyledToolBar>
        <Box display="flex" gap="5px" alignItems="center">
          <IconButton
            aria-label="delete"
            sx={{
              display: { xs: "block", sm: "none" },
              borderRadius: "5px",
              border: `solid 1px ${grey[50]}`,
              padding: "5px 5px 0px 5px",
            }}
            onClick={handleDrawerToggle}
          >
            <MenuIcon sx={{ color: grey[50] }} />
          </IconButton>
          <Plumbing />
          <Typography
            variant="h6"
            sx={{
              fontSize: {
                xs: "11px",
                sm: "20px",
              },
            }}
          >
            מערכת לניהול פרוייקטים ועובדים
          </Typography>
        </Box>

        <ActionsBar>
          <Tooltip title="התנתק">
            <IconButton onClick={logoutUser}>
              <LogoutIcon sx={{ color: "white" }} />
            </IconButton>
          </Tooltip>
        </ActionsBar>
      </StyledToolBar>
    </AppBar>
  );
};

export default Navbar;
