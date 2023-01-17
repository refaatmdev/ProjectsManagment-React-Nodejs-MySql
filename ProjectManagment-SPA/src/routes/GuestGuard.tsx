import React, { PropsWithChildren, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useAppSelector } from "../store/hooks";

const GuestGuard = ({ children }: PropsWithChildren) => {
  const { isLoggedIn } = useAppSelector((state) => state.auth);
  const navigate = useNavigate();

  useEffect(() => {
    if (isLoggedIn) {
      navigate("/dashboard", { replace: true });
    }
  }, [isLoggedIn, navigate]);

  return <>{children}</>;
};

export default GuestGuard;
