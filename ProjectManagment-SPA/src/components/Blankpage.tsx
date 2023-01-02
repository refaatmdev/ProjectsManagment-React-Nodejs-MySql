import { Toolbar } from "@mui/material";
import { Box } from "@mui/system";
import React from "react";
import Footer from "./Footer";

const Blankpage = () => {
  return (
    <Box
      sx={{
        position: "relative",
        minHeight: `calc(100vh - 110px)`,
        display: "flex",
        flexDirection: "column",
      }}
    >
      <Toolbar />
      <Box  sx={{ m: "10px" }} bgcolor="green">
        Blankpage
      </Box>
      <Footer />
    </Box>
  );
};

export default Blankpage;
