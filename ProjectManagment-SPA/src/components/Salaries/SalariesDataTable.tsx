import React, { useCallback, useEffect, useMemo, useState } from "react";
import {
  Box,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Stack,
  IconButton,
  TableFooter,
} from "@mui/material";
import { IMafrea } from "../../_interfaces/mafrea.interfac";
import dayjs from "dayjs";
import CurrencyFormat from "react-currency-format";
import { DeleteOutlined, EditOutlined } from "@mui/icons-material";
import { IEmployee } from "../../_interfaces/emplyee.interface";
import { useAppDispatch, useAppSelector } from "../../store/hooks";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import EmployeeAction from "../Employees/EmployeeAction";
import { deleteMafrea } from "../../store/recordsSlice";
import { useLocation } from "react-router-dom";
const MySwal = withReactContent(Swal);

interface ISalariesDataTableProps {
  data: any[];
  path: string;
}
const SalariesDataTable = ({ data, path }: ISalariesDataTableProps) => {
  const [total, setTotal] = useState(0);
  const [totalOfAllSalaries, setTotalOfAllSalaries] = useState(0);

  useEffect(() => {
    const getTotalOfAllSalaries = data
      .map((t: any) => t.total)
      .reduce((acc: any, value: any) => acc + Number(value), 0);
    setTotal(getTotalOfAllSalaries);

    const getTotalOfSalariesByMonth = data
      .map((t: any) => t.salary)
      .reduce((acc: any, value: any) => acc + Number(value), 0);
    setTotalOfAllSalaries(getTotalOfSalariesByMonth);
  }, [data, totalOfAllSalaries, total]);

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
                <TableCell sx={{ pl: 3 }}>#</TableCell>
                <TableCell align="center">תאריך</TableCell>
                {path === "Employees" && (
                  <>
                    <TableCell align="center"> שם עובד</TableCell>
                    <TableCell align="center">ימי עבודה</TableCell>
                    <TableCell align="center">שכר עבודה</TableCell>
                  </>
                )}
                <TableCell align="center">סכום</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {Array.isArray(data) &&
                data.map((row, index) => {
                  return (
                    <TableRow hover key={index}>
                      <TableCell align="center">{index + 1}</TableCell>
                      <TableCell align="center">
                        {dayjs(row.salaryDate).format("YYYY-MM-DD")}
                      </TableCell>
                      {row.firstName && (
                        <TableCell align="center">
                          {row.firstName + " " + row.lastName}{" "}
                        </TableCell>
                      )}

                      {row.duration && (
                        <TableCell align="center">
                          {(row.duration / 8.5).toFixed(3)}
                        </TableCell>
                      )}

                      {row.dailyWage && (
                        <TableCell align="center">
                          <CurrencyFormat
                            value={row.dailyWage}
                            displayType={"text"}
                            thousandSeparator={true}
                            prefix={"₪"}
                          />
                        </TableCell>
                      )}
                      {row.total && (
                        <TableCell align="center">
                          <CurrencyFormat
                            value={row.total}
                            displayType={"text"}
                            thousandSeparator={true}
                            prefix={"₪"}
                          />
                        </TableCell>
                      )}
                      {row.salary && (
                        <TableCell align="center">
                          <CurrencyFormat
                            value={row.salary}
                            displayType={"text"}
                            thousandSeparator={true}
                            prefix={"₪"}
                          />
                        </TableCell>
                      )}
                    </TableRow>
                  );
                })}
            </TableBody>
            <TableFooter>
              <TableRow>
                <TableCell></TableCell>
                {path === "Employees" && (
                  <>
                    <TableCell></TableCell>
                    <TableCell></TableCell>
                    <TableCell></TableCell>
                  </>
                )}
                <TableCell align="right">סך הכל</TableCell>
                <TableCell align="center">
                  {path === "Employees" ? (
                    <CurrencyFormat
                      value={totalOfAllSalaries}
                      displayType={"text"}
                      thousandSeparator={true}
                      prefix={"₪"}
                    />
                  ) : (
                    <CurrencyFormat
                      value={total}
                      displayType={"text"}
                      thousandSeparator={true}
                      prefix={"₪"}
                    />
                  )}
                </TableCell>
              </TableRow>
            </TableFooter>
          </Table>
        </TableContainer>
      </Box>
    </>
  );
};

export default SalariesDataTable;
