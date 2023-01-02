import { Alert, Snackbar } from "@mui/material";
import React, { useEffect } from "react";
import { useAppDispatch, useAppSelector } from "../store/hooks";
import { close } from "../store/snackBardSlice";

const SnakBar = () => {
  const { msg, type, open } = useAppSelector((state) => state.snackBardSlice);
  const dispatch = useAppDispatch();
  function handleClose() {
    dispatch(close());
  }
  useEffect(() => {});
  return (
    <>
      <Snackbar
        open={open}
        autoHideDuration={4000}
        anchorOrigin={{ vertical: "bottom", horizontal: "right" }}
        onClose={handleClose}
      >
        <Alert severity={type} sx={{ width: "100%" }} onClose={handleClose}>
          {msg}
        </Alert>
      </Snackbar>
    </>
  );
};

export default SnakBar;
