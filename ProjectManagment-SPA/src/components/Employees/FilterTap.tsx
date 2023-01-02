import * as React from "react";

import { TextField } from "@mui/material";
import MainCard from "../customizeComponents/MainCard";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";

interface FilterDateProps {
  handelDateValueChanged: (e: any) => void;
  value: string;
}
const FilterTap = ({ handelDateValueChanged, value }: FilterDateProps) => {
  return (
    <MainCard title="חפש דוחות לפי תאריך">
      <LocalizationProvider
        dateAdapter={AdapterDayjs}
        styles={{ width: "100%" }}
      >
        <DatePicker
          openTo="month"
          views={["year", "month"]}
          label="בחר תאריך"
          value={value}
          onChange={(e) => handelDateValueChanged(e)}
          renderInput={(params) => <TextField {...params} helperText={null} />}
        />
      </LocalizationProvider>
    </MainCard>
  );
};

export default FilterTap;
