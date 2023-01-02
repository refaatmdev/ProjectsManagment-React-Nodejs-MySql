import { grey } from "@ant-design/colors";
import { Button, Typography } from "@mui/material";
import React from "react";
import MainCard from "../customizeComponents/MainCard";
import DownloadIcon from "@mui/icons-material/Download";
import downloadAsPDF from "../../helpers/pdfDownloader";
import { IEmployee } from "../../_interfaces/emplyee.interface";
import { IdataTable } from "../../pages/Employees/Employee";
interface props {
  employeeData: IEmployee;
  currentMonth: string;
  monthDays: IdataTable[];
  disable: boolean;
}
const DownloadTimeSheetAsPdf = ({
  employeeData,
  currentMonth,
  monthDays,
  disable,
}: props) => {
  return (
    <MainCard title="הורדה ב pdf">
      <Typography color={grey[800]}>שמירת שעות העבודה ב pdf</Typography>
      <Button
        sx={{ mt: 2 }}
        disabled={disable}
        onClick={() =>
          downloadAsPDF({
            employeeData: employeeData,
            currentMonth: currentMonth,
            monthDays: monthDays,
          })
        }
        variant="contained"
        endIcon={<DownloadIcon />}
      >
        לחץ להורדה
      </Button>
    </MainCard>
  );
};

export default DownloadTimeSheetAsPdf;
