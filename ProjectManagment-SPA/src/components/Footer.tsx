import { Stack, Typography } from "@mui/material";
import React from "react";

const Footer = () => {
  return (
    <Stack
      direction="row"
      justifyContent="space-between"
      alignItems="center"
      sx={{ p: "24px 16px 0px", mt: "auto" }}
    >
      <Typography variant="caption">כל הזכויות שמורות &copy;</Typography>
    </Stack>
  );
};

export default Footer;
