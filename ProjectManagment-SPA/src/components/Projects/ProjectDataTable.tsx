import {
  Box,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
} from "@mui/material";
import React from "react";
import dayjs from "dayjs";
import CurrencyFormat from "react-currency-format";
import { IEmployee } from "../../_interfaces/emplyee.interface";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { IProjectDataTable } from "../../store/recordsSlice";

const MySwal = withReactContent(Swal);

interface IProjectRecordsDataTableProps {
  records: IProjectDataTable[];
}
const ProjectDataTable = ({ records }: IProjectRecordsDataTableProps) => {
  return (
    <>
      <Box
        sx={{
          width: "100%",
          height: "400px",
          display: "table",
          tableLayout: "fixed",
        }}
      >
        <TableContainer>
          <Table sx={{ minWidth: 350 }} aria-label="simple table">
            <TableHead>
              <TableRow>
                <TableCell>#</TableCell>
                <TableCell sx={{ pl: 3 }}>תאריך</TableCell>
                <TableCell align="center">יום</TableCell>
                <TableCell align="center">שם עובד</TableCell>
                <TableCell align="center">התחיל </TableCell>
                <TableCell align="center">סיים</TableCell>
                <TableCell align="center">זמן</TableCell>
                <TableCell align="center">שכר יומי</TableCell>
                <TableCell align="center">לתשלום</TableCell>
                <TableCell align="center">הערות/נעשה</TableCell>
                <TableCell align="center">הערה כללית</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {Array.isArray(records) &&
                records.map((row, index) => {
                  const convertToDay = dayjs(row.date).format("dddd");
                  const startAt = row.startAt
                    ? dayjs(row.startAt).format("HH:mm")
                    : "";
                  const endAt = row.endAt
                    ? dayjs(row.endAt).format("HH:mm")
                    : "";
                  return (
                    <TableRow hover key={index}>
                      <TableCell width={"50px"}>{index + 1}</TableCell>
                      <TableCell width={"50px"}>
                        {dayjs(row.date).format("YY-MM-DD")}
                      </TableCell>
                      <TableCell>{convertToDay}</TableCell>

                      <TableCell>
                        {row.firstName + " " + row.lastName}
                      </TableCell>

                      <TableCell>{startAt}</TableCell>
                      <TableCell>{endAt}</TableCell>
                      <TableCell>{row.duration}</TableCell>
                      <TableCell>
                        {row.dailyWage && (
                          <CurrencyFormat
                            value={row.dailyWage}
                            displayType={"text"}
                            thousandSeparator={true}
                            prefix={"₪"}
                          />
                        )}
                      </TableCell>
                      <TableCell>
                        {row.payPerDay && (
                          <CurrencyFormat
                            value={row.payPerDay}
                            displayType={"text"}
                            thousandSeparator={true}
                            prefix={"₪"}
                          />
                        )}
                      </TableCell>
                      <TableCell>{row.projectNotes}</TableCell>
                      <TableCell>{row.notes}</TableCell>
                    </TableRow>
                  );
                })}
            </TableBody>
          </Table>
        </TableContainer>
      </Box>
    </>
  );
};

export default ProjectDataTable;
