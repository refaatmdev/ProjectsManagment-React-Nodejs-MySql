import { InputBase } from "@mui/material";
import React, { ChangeEvent } from "react";

interface FilterEmployeesProps {
  handelSearchValueChanged: (e: ChangeEvent<HTMLInputElement>) => void;
}
export default function FilterEmployees({
  handelSearchValueChanged,
}: FilterEmployeesProps) {
  return (
    <>
      <InputBase
        placeholder="הכנס שם עובד"
        onChange={handelSearchValueChanged}
      />
    </>
  );
}
