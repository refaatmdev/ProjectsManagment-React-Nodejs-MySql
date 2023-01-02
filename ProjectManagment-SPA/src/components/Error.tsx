import React, { PropsWithChildren } from "react";

import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { useAppSelector } from "../store/hooks";

const MySwal = withReactContent(Swal);
interface errorProps extends PropsWithChildren {
  error: string;
  loading?: boolean;
}
const Error = ({ error, children }: errorProps) => {
  return (
    <>
      {error && error.length > 0
        ? MySwal.fire({
            title: "Are you sure?",
            text: "User will have Admin Privileges",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Yes!",
          })
        : { children }}
    </>
  );
};

export default Error;
