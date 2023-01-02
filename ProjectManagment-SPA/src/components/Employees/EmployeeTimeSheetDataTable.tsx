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
} from "@mui/material";
import React, { useCallback, useMemo, useState } from "react";
import dayjs from "dayjs";
import CurrencyFormat from "react-currency-format";
import convertProjectIToName from "../../helpers/convertProjectIdToName";
import { IEmployee } from "../../_interfaces/emplyee.interface";
import { DeleteOutlined, EditOutlined } from "@mui/icons-material";
import AddReports from "../Reports/AddReports";
import { IRecord } from "../../_interfaces/record.interface";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { deleteRecord, getAllRecords } from "../../store/recordsSlice";
import { useAppDispatch } from "../../store/hooks";

const MySwal = withReactContent(Swal);

interface IEmployeeDataTableProps {
  records: any[];
  employee: IEmployee | null;
}
export interface IDayWorked {
  projectId: number;
  projectName: string;
  notes: string;
}
export const EmployeeTimeSheetDataTable = ({
  records,
  employee,
}: IEmployeeDataTableProps) => {
  const [open, setOpen] = useState<boolean>(false);
  const [selectedRecord, setSelectedRecord] = useState<IRecord>();
  const dispatch = useAppDispatch();

  const projectName = useCallback(
    (projectsId: IDayWorked) => {
      return convertProjectIToName(projectsId);
    },
    [records]
  );

  const handelOpenModal = useCallback(
    (data: IRecord) => {
      setOpen(true);
      setSelectedRecord(data);
    },
    [open]
  );
  const handelClose = useCallback(() => {
    setOpen(false);
  }, [open]);

  const reportMemo = useMemo(
    () => (
      <AddReports data={selectedRecord} open={open} handelClose={handelClose} />
    ),
    [open]
  );

  const handelDeleteRecord = useCallback(
    (data: IRecord) => {
      MySwal.fire({
        title: `דדיווח האם אתה בטוח שרוצה למחוק את דיווח  - ${data.date}?`,
        text: "לא תוכל לשחזר או לבטל את הפעולה",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "כן, מחק!",
        cancelButtonText: "בטל",
      }).then((result) => {
        if (result.isConfirmed) {
          dispatch(deleteRecord({ recordId: Number(data.id) })).then(() =>
            dispatch(getAllRecords({}))
          );
          MySwal.fire({
            title: "נמחק!",
            text: `${data.date} דיווח  נמחק`,
            icon: "success",
            confirmButtonText: "תודה!",
          });
        }
      });
    },
    [dispatch]
  );

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
                <TableCell sx={{ pl: 3 }}>תאריך</TableCell>
                <TableCell align="center">יום</TableCell>
                {!employee && <TableCell align="center">שם עובד</TableCell>}
                <TableCell align="center">מיקום עבודה</TableCell>
                <TableCell align="center">התחיל </TableCell>
                <TableCell align="center">סיים</TableCell>
                <TableCell align="center">זמן</TableCell>
                <TableCell align="center">שכר יומי</TableCell>
                <TableCell align="center">לתשלום</TableCell>
                <TableCell align="center">הערות</TableCell>
                <TableCell align="center">פעולה</TableCell>
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
                      <TableCell width={"50px"}>{row.date}</TableCell>
                      <TableCell>{convertToDay}</TableCell>
                      {!employee && (
                        <TableCell>
                          {row.firstName + " " + row.lastName}
                        </TableCell>
                      )}
                      <TableCell>
                        {row.projectId ? projectName(row.projectId) : "חופש"}
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
                      <TableCell>{row.notes}</TableCell>
                      <TableCell align="center" sx={{ pr: 3 }}>
                        {row.id && (
                          <Stack
                            direction="row"
                            justifyContent="center"
                            alignItems="center"
                          >
                            <IconButton
                              color="primary"
                              size="large"
                              onClick={() => {
                                handelOpenModal(row);
                              }}
                            >
                              <EditOutlined />
                            </IconButton>
                            <IconButton
                              color="inherit"
                              size="large"
                              onClick={() => handelDeleteRecord(row)}
                            >
                              <DeleteOutlined />
                            </IconButton>
                          </Stack>
                        )}
                      </TableCell>
                    </TableRow>
                  );
                })}
            </TableBody>
          </Table>
        </TableContainer>
      </Box>
      {open && reportMemo}
    </>
  );
};
