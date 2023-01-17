import * as React from "react";
import axios from "axios";
import { useAppDispatch, useAppSelector } from "./store/hooks";
import { useEffect } from "react";
import {
  getLoginStatus,
  getUser,
  selectIsLoggedIn,
  selectUser,
} from "./store/authSlice";
import { msg } from "./store/snackBardSlice";
import { RouterProvider } from "react-router-dom";
import router from "./routes";

axios.defaults.withCredentials = true;

function App() {
  // const dispatch = useAppDispatch();
  // const isLoggedIn = useAppSelector(selectIsLoggedIn);
  // const user = useAppSelector(selectUser);

  // useEffect(() => {
  //   console.log("render appts");
  //   // dispatch(getLoginStatus())
  //   //   .unwrap()
  //   //   .catch((error) => dispatch(msg({ msg: error, type: "error" })));
  //   // if (isLoggedIn && user === null) {
  //   //   dispatch(getUser());
  //   // }
  // }, [dispatch, isLoggedIn, user]);

  return (
    <>
      <RouterProvider router={router} />
    </>
  );
}

export default App;
