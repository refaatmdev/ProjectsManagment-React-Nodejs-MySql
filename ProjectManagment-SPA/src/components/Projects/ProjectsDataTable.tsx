import React, { useCallback } from "react";
import {
  Chip,
  IconButton,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
} from "@mui/material";
import { EditOutlined, DeleteOutlined } from "@ant-design/icons";
import { Link } from "react-router-dom";

import { useAppDispatch } from "../../store/hooks";
import { IProject } from "../../_interfaces/project.interface";
import { deleteProject } from "../../store/projectsSlice";
import dayjs from "dayjs";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
const MySwal = withReactContent(Swal);

interface IProjectsDataProps {
  ITEMS_PER_PAGE: number;
  data: IProject[];
  currentPage: number;
  openEditModal: (project: IProject) => void;
}
const ProjectsDataTable = ({
  data,
  ITEMS_PER_PAGE,
  currentPage,
  openEditModal,
}: IProjectsDataProps) => {
  const dispatch = useAppDispatch();

  const handelDeleteProject = useCallback(
    (data: IProject) => {
      MySwal.fire({
        title: `האם אתה בטוח שרוצה למחוק את ${data.projectName}?`,
        text: "לא תוכל לשחזר או לבטל את הפעולה",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "כן, מחק!",
        cancelButtonText: "בטל",
      }).then((result) => {
        if (result.isConfirmed) {
          dispatch(deleteProject({ projectId: Number(data.id) }));
          MySwal.fire({
            title: "נמחק!",
            text: `${data.projectName}  פרויקט בשם נמחק`,
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
              <TableCell sx={{ pl: 3 }}>שם פרוייקט</TableCell>
              <TableCell>מספר פלאפון</TableCell>
              <TableCell>מיקום</TableCell>
              <TableCell>מחיר</TableCell>
              <TableCell align="right">שולם</TableCell>
              <TableCell align="center">לא שולם</TableCell>
              <TableCell align="center">חחריגים</TableCell>
              <TableCell align="center">הסכם</TableCell>
              <TableCell align="center">תאריך התחלה</TableCell>
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
                    to={`/Projects/${row.id}`}
                    style={{ textDecoration: "none", color: "inherit" }}
                  >
                    {row.projectName}
                  </Link>
                </TableCell>
                <TableCell>{row.clientPhone}</TableCell>
                <TableCell align="center">{row.location}</TableCell>
                <TableCell>{row.quotation}</TableCell>
                <TableCell align="right">{row.paid}</TableCell>
                <TableCell align="center">
                  {row.unPaid != undefined && (
                    <Chip
                      color={"error"}
                      label={row.unPaid}
                      // label={row.quotation ? row.quotation - row!.paid : row.quotation}
                      size="small"
                    />
                  )}
                </TableCell>
                <TableCell align="right">{row.haregem}</TableCell>
                <TableCell align="right">{row.quotation}</TableCell>
                <TableCell align="right">
                  {dayjs(row.createdAt).format("DD-MM-YYYY")}
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
                      onClick={() => openEditModal(row)}
                    >
                      <EditOutlined />
                    </IconButton>
                    <IconButton
                      color="inherit"
                      size="large"
                      onClick={() => handelDeleteProject(row)}
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
    </>
  );
};

export default ProjectsDataTable;
