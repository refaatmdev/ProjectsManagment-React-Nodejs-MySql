import * as React from "react";

import { Box, Button, TextField } from "@mui/material";
import MainCard from "../customizeComponents/MainCard";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";
import { useState } from "react";
import dayjs from "dayjs";

interface FilterDateProps {
  handelDateValueChanged: (e: any) => void;
}
const FilterTap = ({ handelDateValueChanged }: FilterDateProps) => {
  const [newData, setNewData] = useState<any>(
    dayjs().format("YYYY-MM-DD HH:mm:ss")
  );
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
          value={newData}
          onChange={(e) => setNewData(e)}
          renderInput={(params) => <TextField {...params} helperText={null} />}
        />
      </LocalizationProvider>

      <Box pt={2} sx={{ display: "flex", justifyContent: "center" }}>
        <Button
          variant="contained"
          onClick={() => handelDateValueChanged(newData)}
        >
          הצג
        </Button>
      </Box>
    </MainCard>
  );
};

export default FilterTap;
