import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { getLoginStatus } from "../store/authSlice";
import { useAppDispatch, useAppSelector } from "../store/hooks";

interface props {
  path: string;
}
const useRedirectLoggedOutUser = () => {
  const navigate = useNavigate();
  const dispatch = useAppDispatch();
  const { isLoggedIn } = useAppSelector((state) => state.auth);
  useEffect(() => {
    const redirectLoggedOutUser = async () => {
      try {
        dispatch(getLoginStatus());
      } catch (error: any) {
        console.log(error.message);
      }

      if (!isLoggedIn) {
        navigate("auth/login");
        return;
      }
    };
    redirectLoggedOutUser();
  }, [navigate]);
};

export default useRedirectLoggedOutUser;
