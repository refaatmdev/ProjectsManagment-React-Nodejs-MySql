import {
  Box,
  Drawer,
  ListItemIcon,
  ListItemText,
  MenuItem,
  MenuList,
  Toolbar,
  ListItemButton,
  useMediaQuery,
  useTheme,
} from "@mui/material";
import React, {
  forwardRef,
  ForwardRefExoticComponent,
  RefAttributes,
  useEffect,
  useState,
} from "react";
import { styled } from "@mui/system";
import { sideBarWidth } from "../Layout/config";
import { grey } from "@mui/material/colors";
import { menuItems } from "../Layout/menu/ItemMenu";
import { Link } from "react-router-dom";

const StyledSideBar = styled(Box)(({ theme }) => ({
  postitions: "sticky",
  top: " 70px",
  height: "calc(100vh - 70px)",
  overflow: "scroll",
  //display: { xs: "none", sm: "block" },
}));

interface ISideBarProps {
  handleDrawerToggle: () => void;
  mobileOpen: boolean;
}
const Sidebar = ({ handleDrawerToggle, mobileOpen }: ISideBarProps) => {
  const theme = useTheme();
  const [open, setOpen] = useState<boolean>(true);
  const matchDownMD = useMediaQuery(theme.breakpoints.down("md"));
  const [selectedIndex, setSelectedIndex] = useState(1);

  useEffect(() => {
    setOpen(!matchDownMD);
  }, [matchDownMD]);

  const handleListItemClick = (event: any, index: number) => {
    setSelectedIndex(index);
  };
  const SideBarContent = (
    <>
      <Toolbar />
      <Box sx={{ width: 320, maxWidth: "100%" }}>
        <MenuList>
          {menuItems.length > 0 &&
            menuItems.map(({ icon: Icon, id, ...menu }) => (
              <MenuItem
                onClick={(event) => handleListItemClick(event, id)}
                key={id}
                {...menu}
                selected={selectedIndex === id}
                sx={{
                  height: "50px",
                  ...{
                    "&:hover": {
                      bgcolor:
                        theme.palette.mode === "dark"
                          ? "divider"
                          : "primary.lighter",
                    },
                    "&.Mui-selected": {
                      bgcolor:
                        theme.palette.mode === "dark"
                          ? "divider"
                          : "primary.lighter",
                      borderRight: `2px solid ${theme.palette.primary.main}`,
                      "&:hover": {
                        bgcolor:
                          theme.palette.mode === "dark"
                            ? "divider"
                            : "primary.lighter",
                      },
                    },
                  },
                }}
              >
                {/* <Link
                  to={menu.link}
                  style={{ color: "inherit", textDecoration: "none" }}
                > */}
                <ListItemButton
                  component={Link}
                  sx={{ "&:hover": { bgcolor: "none" } }}
                  to={menu.link}
                >
                  <ListItemIcon>
                    <Icon fontSize="small" />
                  </ListItemIcon>
                  <ListItemText>{menu.label}</ListItemText>
                </ListItemButton>
                {/* </Link> */}
              </MenuItem>
            ))}
        </MenuList>
      </Box>
    </>
  );
  return (
    <>
      <Drawer
        variant="temporary"
        open={mobileOpen}
        onClose={handleDrawerToggle}
        ModalProps={{
          keepMounted: true, // Better open performance on mobile.
        }}
        sx={{
          display: { xs: "block", sm: "none" },
          "& .MuiDrawer-paper": {
            boxSizing: "border-box",
            width: sideBarWidth,
            borderRight: `1px solid ${grey[200]}`,
            backgroundImage: "none",
            boxShadow: "inherit",
          },
        }}
      >
        {SideBarContent}
      </Drawer>
      <Drawer
        variant="permanent"
        sx={{
          display: { xs: "none", sm: "block" },
          "& .MuiDrawer-paper": {
            boxSizing: "border-box",
            width: sideBarWidth,
          },
        }}
        open
      >
        {SideBarContent}
      </Drawer>
    </>
  );
};

export default Sidebar;

{
  /* <MenuItem sx={{ height: "50px" }}>
            <ListItemIcon>
              <PrecisionManufacturingIcon fontSize="small" />
            </ListItemIcon>
            <ListItemText>פרוייקטים</ListItemText>
          </MenuItem>
          <MenuItem sx={{ height: "50px" }}>
            <ListItemIcon>
              <PrecisionManufacturingIcon fontSize="small" />
            </ListItemIcon>
            <ListItemText>עובדים</ListItemText>
          </MenuItem>
          <MenuItem sx={{ height: "50px" }}>
            <ListItemIcon>
              <HourglassBottomIcon fontSize="small" />
            </ListItemIcon>
            <ListItemText>דיווח שעות עבודה</ListItemText>
          </MenuItem>
          <MenuItem sx={{ height: "50px" }}>
            <ListItemIcon>
              <AttachMoneyIcon fontSize="small" />
            </ListItemIcon>
            <ListItemText>דוחות שכר</ListItemText>
          </MenuItem> */
}
