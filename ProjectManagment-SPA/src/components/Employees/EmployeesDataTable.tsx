import React, { useCallback, useState } from "react";
import {
  Chip,
  IconButton,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TablePagination,
  TableRow,
} from "@mui/material";
import { EditOutlined, DeleteOutlined } from "@ant-design/icons";
import { IEmployee } from "../../_interfaces/emplyee.interface";
import EmployeeAction from "./EmployeeAction";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { useAppDispatch } from "../../store/hooks";
import { deleteEmployee } from "../../store/employeesSlice";

const MySwal = withReactContent(Swal);

interface IemployDataProps {
  ITEMS_PER_PAGE: number;
  data: IEmployee[];
  currentPage: number;
}
const EmployeesDataTable = ({
  data,
  ITEMS_PER_PAGE,
  currentPage,
}: IemployDataProps) => {
  const [show, setShow] = useState(false);
  const [type, setType] = useState("");
  const [selectedEmployee, setSelectedEmployee] = useState<IEmployee>();
  const dispatch = useAppDispatch();

  const handleClose = () => {
    setShow(false);
    setSelectedEmployee(undefined);
  };

  const handelOpenModal = useCallback(
    (t: string, data: IEmployee) => {
      setShow(true);
      setType(t);
      setSelectedEmployee(data);
    },
    [show]
  );

  const handelDeleteEmployee = useCallback(
    (data: IEmployee) => {
      MySwal.fire({
        title: `האם אתה בטוח שרוצה למחוק את ${data.firstName} ${data.lastName} ?`,
        text: "לא תוכל לשחזר או לבטל את הפעולה",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "כן, מחק!",
        cancelButtonText: "בטל",
      }).then((result) => {
        if (result.isConfirmed) {
          dispatch(deleteEmployee({ employeeId: Number(data.id) }));
          MySwal.fire({
            title: "נמחק!",
            text: `${data.firstName} ${data.lastName} עובד בשם נמחק`,
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
      <TableContainer>
        <Table sx={{ minWidth: 350 }} aria-label="simple table">
          <TableHead>
            <TableRow>
              <TableCell sx={{ pl: 3 }}>#</TableCell>
              <TableCell sx={{ pl: 3 }}>שם מלא</TableCell>
              <TableCell>מספר פלאפון</TableCell>
              <TableCell>שכר יומי</TableCell>
              <TableCell>חשבון בנק</TableCell>
              <TableCell align="right">סניף</TableCell>
              <TableCell align="center">סטטוס</TableCell>
              <TableCell align="center" sx={{ pr: 3 }}>
                פעולה
              </TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {data.map((row, index) => (
              <TableRow hover key={index}>
                <TableCell>
                  {(currentPage - 1) * ITEMS_PER_PAGE + (index + 1)}
                </TableCell>
                <TableCell sx={{ pl: 3 }}>
                  <Link
                    to={`/Employees/${row.id}`}
                    style={{ textDecoration: "none", color: "inherit" }}
                  >
                    {row.firstName} {row.lastName}
                  </Link>
                </TableCell>
                <TableCell>{row.phone}</TableCell>
                <TableCell align="center">{row.dailyWage}</TableCell>
                <TableCell>{row.bankAccount}</TableCell>
                <TableCell align="right">{row.bankBranch}</TableCell>
                <TableCell align="center">
                  <Chip
                    color={row.isActive == 1 ? "success" : "error"}
                    label={row.isActive == 1 ? "פעיל" : "לא פעיל"}
                    size="small"
                  />
                </TableCell>

                <TableCell align="center" sx={{ pr: 3 }}>
                  <Stack
                    direction="row"
                    justifyContent="center"
                    alignItems="center"
                  >
                    <IconButton
                      color="primary"
                      size="large"
                      onClick={() => {
                        handelOpenModal("editEmployee", row);
                      }}
                    >
                      <EditOutlined />
                    </IconButton>
                    <IconButton
                      color="inherit"
                      size="large"
                      onClick={() => handelDeleteEmployee(row)}
                    >
                      <DeleteOutlined />
                    </IconButton>
                  </Stack>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      <EmployeeAction
        handleClose={handleClose}
        show={show}
        type={type}
        headTitle="עריכת עובד"
        employee={selectedEmployee}
      />
    </>
  );
};

export default EmployeesDataTable;
