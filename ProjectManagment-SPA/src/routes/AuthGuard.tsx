import axios from "axios";
import React, { PropsWithChildren, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import {
  API_URL,
  getUser,
  selectIsLoggedIn,
  selectUser,
} from "../store/authSlice";
import { useAppDispatch, useAppSelector } from "../store/hooks";

const getLoginStatus = async () => {
  const response = await axios.get(API_URL + "/loginStatus");
  return response.data;
};

const AuthGuard = ({ children }: PropsWithChildren) => {
  // const isLoggedIn = useAppSelector(selectIsLoggedIn);
  const user = useAppSelector(selectUser);
  const navigate = useNavigate();
  const dispatch = useAppDispatch();

  useEffect(() => {
    let isLoggedIn: boolean;

    const redirectLoggedOutUser = async () => {
      try {
        isLoggedIn = await getLoginStatus();
        console.log(isLoggedIn);
        if (isLoggedIn && user === null) {
          dispatch(getUser());
        }
      } catch (error: any) {
        console.log(error.message);
      }
      // console.log("isLoggedIn", isLoggedIn);
      // if (isLoggedIn && user === null) {
      //   await dispatch(getUser());
      // }
      if (!isLoggedIn) {
        navigate("auth/login");
        return;
      }
    };
    redirectLoggedOutUser();
    // if (!isLoggedIn) {
    //   navigate("auth/login", { replace: true });
    // }
  }, [navigate]);

  return <>{children}</>;
};

export default AuthGuard;
