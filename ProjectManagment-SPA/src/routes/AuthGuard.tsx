import axios from "axios";
import React, { PropsWithChildren, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import {
  API_URL,
  getLoginStatus,
  getUser,
  selectIsLoggedIn,
  selectUser,
} from "../store/authSlice";
import { useAppDispatch, useAppSelector } from "../store/hooks";

const getLoginStatusDirectly = async () => {
  const response = await axios.get(API_URL + "/loginStatus");
  return response.data;
};

const AuthGuard = ({ children }: PropsWithChildren) => {
  const isLoggedIn = useAppSelector(selectIsLoggedIn);
  const user = useAppSelector(selectUser);
  const navigate = useNavigate();
  const dispatch = useAppDispatch();

  useEffect(() => {
    let isLoggedInDirectrly: boolean;

    const redirectLoggedOutUser = async () => {
      try {
        dispatch(getLoginStatus());
        isLoggedInDirectrly = await getLoginStatusDirectly();
      } catch (error: any) {
        console.log(error.message);
      }
      if (isLoggedIn && user === null) {
        await dispatch(getUser());
      }
      if (!isLoggedInDirectrly) {
        navigate("auth/login");
        return;
      }
    };
    redirectLoggedOutUser();
  }, [navigate]);

  return <>{children}</>;
};

export default AuthGuard;
