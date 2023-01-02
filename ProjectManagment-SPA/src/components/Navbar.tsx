import { styled } from "@mui/system";
import {
  AppBar,
  Avatar,
  Badge,
  Box,
  IconButton,
  InputBase,
  Menu,
  MenuItem,
  Toolbar,
  Typography,
} from "@mui/material";
import React, { useState } from "react";
import { Plumbing, Mail, Notifications } from "@mui/icons-material";
import MenuIcon from "@mui/icons-material/Menu";
import { grey } from "@mui/material/colors";

const StyledToolBar = styled(Toolbar)(({ theme }) => ({
  display: "flex",
  justifyContent: "space-between",
}));

const Search = styled("div")(({ theme }) => ({
  display: "none",
  backgroundColor: "white",
  padding: "0 10px",
  borderRadius: theme.shape.borderRadius,
  width: "40%",
  [theme.breakpoints.up("sm")]: {
    display: "flex",
  },
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
  const [open, setOpen] = useState<boolean>(false);
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
        <Search>
          <InputBase placeholder="חיפוש.." />
        </Search>
        <ActionsBar>
          <Badge badgeContent={4} color="error">
            <Mail />
          </Badge>
          <Badge badgeContent={4} color="error">
            <Notifications />
          </Badge>
          <Avatar
            sx={{
              width: 30,
              height: 30,
              alignItems: "center",
              cursor: "pointer",
            }}
            alt="Remy Sharp"
            src="../../assets/images/profile/user.svg"
            onClick={(e: any) => setOpen(true)}
          />
          <Menu
            id="demo-positioned-menu"
            aria-labelledby="demo-positioned-button"
            open={open}
            onClose={(e) => setOpen(false)}
            anchorOrigin={{
              vertical: "top",
              horizontal: "left",
            }}
            transformOrigin={{
              vertical: "top",
              horizontal: "left",
            }}
          >
            <MenuItem>Profile</MenuItem>
            <MenuItem>My account</MenuItem>
            <MenuItem>Logout</MenuItem>
          </Menu>
        </ActionsBar>
      </StyledToolBar>
    </AppBar>
  );
};

export default Navbar;
