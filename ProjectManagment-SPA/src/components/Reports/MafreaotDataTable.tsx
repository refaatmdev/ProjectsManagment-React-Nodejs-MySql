import React, { useCallback, useMemo, useState } from "react";
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
const MySwal = withReactContent(Swal);

interface IMafreaotProp {
  data: IMafrea[];
}
const MafreaotDataTable = ({ data }: IMafreaotProp) => {
  const [show, setShow] = useState(false);
  const [type, setType] = useState("");
  const [selectedMafrea, setSelectedMafrea] = useState<IMafrea>();
  const dispatch = useAppDispatch();

  const handleClose = () => {
    setShow(false);
    setSelectedMafrea(undefined);
  };

  const handelOpenModal = useCallback(
    (data: IMafrea) => {
      setShow(true);
      setSelectedMafrea(data);
    },
    [show]
  );

  const mafreaActionMemo = useMemo(
    () => (
      <EmployeeAction
        handleClose={handleClose}
        show={show}
        type="editRiot"
        headTitle="עדכון מפרעה לעובד"
        mafreaData={selectedMafrea}
      />
    ),
    [show]
  );

  const handelDeleteMafrea = useCallback(
    (data: IMafrea) => {
      MySwal.fire({
        title: `האם את בטוח שרוצה למחוק את המפרעה לעובד ${data.firstName} ${data.lastName} בתאריך ${data.createdAt}`,
        text: "לא תוכל לשחזר או לבטל את הפעולה",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "כן, מחק!",
        cancelButtonText: "בטל",
      }).then((result) => {
        if (result.isConfirmed) {
          dispatch(deleteMafrea({ mafreaId: Number(data.id) }));
          MySwal.fire({
            title: "נמחק!",
            text: ` מפרעה של עובד ${data.firstName} ${data.lastName} נמחקה `,
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
                <TableCell align="center">שם עובד</TableCell>
                <TableCell align="center"> סכום מפרעה</TableCell>
                <TableCell align="center">הערות</TableCell>
                <TableCell align="center">פעולה</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {Array.isArray(data) &&
                data.map((row, index) => {
                  return (
                    <TableRow hover key={index}>
                      <TableCell width={"50px"}>{row.createdAt}</TableCell>
                      {row.firstName && (
                        <TableCell width={"50px"}>
                          {row.firstName + " " + row.lastName}
                        </TableCell>
                      )}

                      <TableCell>
                        <CurrencyFormat
                          value={row.amount}
                          displayType={"text"}
                          thousandSeparator={true}
                          prefix={"₪"}
                        />
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
                              onClick={() => handelDeleteMafrea(row)}
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
      {show && mafreaActionMemo}
    </>
  );
};

export default MafreaotDataTable;
