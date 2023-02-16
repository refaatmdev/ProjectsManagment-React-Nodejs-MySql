import { createSlice, PayloadAction } from "@reduxjs/toolkit";

import { BASE_URL } from "../config";
import { AlertProps } from "@mui/material";

const API_URL = `${BASE_URL}/timesSheet`;

interface Iinitvalues {
  msg: string;
  open: boolean;
  type: AlertProps["severity"];
}

const initalValue: Iinitvalues = {
  msg: "",
  open: false,
  type: "success",
};

const snackBardSlice = createSlice({
  name: "errors",
  initialState: initalValue,
  reducers: {
    msg: (state, action: PayloadAction<any>) => {
      state.open = true;
      state.msg = action.payload.msg;
      state.type = action.payload.type;
    },

    close: (state) => {
      state.open = false;
    },
  },
});
export const { msg, close } = snackBardSlice.actions;

export default snackBardSlice.reducer;
