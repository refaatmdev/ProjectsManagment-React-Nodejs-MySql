import { createSlice, createAsyncThunk, PayloadAction } from "@reduxjs/toolkit";
import { IEmployee } from "../_interfaces/emplyee.interface";
import axios from "axios";
import { BASE_URL } from "../config";
import { IRecord } from "../_interfaces/record.interface";
import { AlertProps } from "@mui/material";
import { IUser } from "../_interfaces/auth.interface";

export const API_URL = `${BASE_URL}/auth`;

interface Iinitvalues {
  isLoggedIn: boolean;
  user: IUser | null;
  users: [];
  // twoFactor: boolean,
  isError: boolean;
  isSuccess: boolean;
  isLoading: boolean;
  message: any;
}

const initalValue: Iinitvalues = {
  isLoggedIn: false,
  user: null,
  users: [],
  //twoFactor: false,
  isError: false,
  isSuccess: false,
  isLoading: false,
  message: "",
};

// Login User
export const login = createAsyncThunk(
  "auth/login",
  async (userData: IUser, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.post(`${API_URL}/login`, userData, {
        cancelToken: source.token,
      });
      console.log(response);
      if (response.data) return response.data;
    } catch (error: any) {
      const message =
        (error.response &&
          error.response.data &&
          error.response.data.message) ||
        error.message ||
        error.toString();
      return rejectWithValue(message);
    }
  }
);

// Logout User
export const logout = createAsyncThunk(
  "auth/logout",
  async (_, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.post(`${API_URL}/logout`, {
        cancelToken: source.token,
      });
      console.log(response);
      if (response.data) return response.data;
    } catch (error: any) {
      const message =
        (error.response &&
          error.response.data &&
          error.response.data.message) ||
        error.message ||
        error.toString();
      return rejectWithValue(message);
    }
  }
);

// Get Login Status
export const getLoginStatus = createAsyncThunk(
  "auth/getLoginStatus",
  async (_, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      console.log("getLoginStatuss");
      const response = await axios.get(`${API_URL}/loginStatus`, {
        cancelToken: source.token,
      });
      if (response.data) return response.data;
    } catch (error: any) {
      const message =
        (error.response &&
          error.response.data &&
          error.response.data.message) ||
        error.message ||
        error.toString();
      return rejectWithValue(message);
    }
  }
);

// Get User
export const getUser = createAsyncThunk(
  "auth/getUser",
  async (_, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.get(`${API_URL}/getUser`, {
        cancelToken: source.token,
      });
      if (response.data) return response.data;
    } catch (error: any) {
      const message =
        (error.response &&
          error.response.data &&
          error.response.data.message) ||
        error.message ||
        error.toString();
      return rejectWithValue(message);
    }
  }
);

const authdSlice = createSlice({
  name: "auth",
  initialState: initalValue,
  reducers: {
    // msg: (state, action: PayloadAction<any>) => {
    //   console.log(action);
    //   state.open = true;
    //   state.msg = action.payload.msg;
    //   state.type = action.payload.type;
    // },
    // close: (state) => {
    //   state.open = false;
    // },
  },
  extraReducers: (builder) => {
    builder
      // Login User
      .addCase(login.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(login.fulfilled, (state, action) => {
        state.isLoading = false;
        state.isSuccess = true;
        state.isLoggedIn = true;
        state.user = action.payload;
        // toast.success("Login Successful");
        console.log(action.payload);
      })
      .addCase(login.rejected, (state, action) => {
        state.isLoading = false;
        state.isError = true;
        state.message = action.payload;
        state.user = null;
        // toast.error(action.payload);
        // if (action.payload.includes("New browser")) {
        //   state.twoFactor = true;
        // }
      })
      // Logout User
      .addCase(logout.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(logout.fulfilled, (state, action) => {
        state.isLoading = false;
        state.isSuccess = true;
        state.isLoggedIn = false;
        state.user = null;
        // toast.success(action.payload);
      })
      .addCase(logout.rejected, (state, action) => {
        state.isLoading = false;
        state.isError = true;
        state.message = action.payload;
        // toast.error(action.payload);
      })

      // Get Login Status
      .addCase(getLoginStatus.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(getLoginStatus.fulfilled, (state, action) => {
        state.isLoading = false;
        state.isSuccess = true;
        state.isLoggedIn = action.payload;
      })
      .addCase(getLoginStatus.rejected, (state, action) => {
        state.isLoading = false;
        state.isError = true;
        state.message = action.payload;
        console.log(action.payload);
      })
      // Get User
      .addCase(getUser.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(getUser.fulfilled, (state, action) => {
        state.isLoading = false;
        state.isSuccess = true;
        state.isLoggedIn = true;
        state.user = action.payload;
      })
      .addCase(getUser.rejected, (state, action) => {
        state.isLoading = false;
        state.isError = true;
        state.message = action.payload;
        // toast.error(action.payload);
      });
  },
});
// export const { msg, close } = authdSlice.actions;
export const selectIsLoggedIn = (state: any) => state.auth.isLoggedIn;
export const selectUser = (state: any) => state.auth.user;
export default authdSlice.reducer;
