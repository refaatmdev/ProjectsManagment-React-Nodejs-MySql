import {
  Box,
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
import React from "react";
import dayjs from "dayjs";
import CurrencyFormat from "react-currency-format";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { IPaids } from "../../_interfaces/paids.interface";
import { DeleteOutlined, EditOutlined } from "@mui/icons-material";
import { BASE_URL } from "../../config";

const MySwal = withReactContent(Swal);

interface IProjectPaidsDataTableProps {
  paids: IPaids[];
  setSelectedPaid: (paid: IPaids) => void;
  setOpenPaidsAction: (open: boolean) => void;
  handelDeletePaid: (paid: IPaids) => void;
}
const ProjectPaids = ({
  paids,
  setSelectedPaid,
  setOpenPaidsAction,
  handelDeletePaid,
}: IProjectPaidsDataTableProps) => {
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
                <TableCell align="center">סכום</TableCell>
                <TableCell align="center">אופן תשלום </TableCell>
                <TableCell align="center">תמונה </TableCell>
                <TableCell align="center">הערות </TableCell>
                <TableCell align="center">פעולה</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {Array.isArray(paids) &&
                paids.map((row, index) => {
                  return (
                    <TableRow hover key={index}>
                      <TableCell width={"50px"}>{index + 1}</TableCell>
                      <TableCell width={"50px"}>
                        {dayjs(row.paidDate).format("YY-MM-DD")}
                      </TableCell>
                      <TableCell>
                        <CurrencyFormat
                          value={row.paid}
                          displayType={"text"}
                          thousandSeparator={true}
                          prefix={"₪"}
                        />
                      </TableCell>

                      <TableCell>
                        <Chip
                          color={row.method === "check" ? "info" : "warning"}
                          label={row.method === "check" ? "ציק" : "מזומן"}
                          size="small"
                        />
                      </TableCell>

                      <TableCell>
                        {row.checkImg && (
                          <img
                            src={`${BASE_URL}/${row.checkImg}`}
                            width={50}
                            height={50}
                          />
                        )}
                      </TableCell>
                      <TableCell>{row.notes}</TableCell>
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
                              setSelectedPaid(row), setOpenPaidsAction(true);
                              // handelOpenModal("editEmployee", row);
                            }}
                          >
                            <EditOutlined />
                          </IconButton>
                          <IconButton
                            color="inherit"
                            size="large"
                            onClick={() => handelDeletePaid(row)}
                          >
                            <DeleteOutlined />
                          </IconButton>
                        </Stack>
                      </TableCell>
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

export default ProjectPaids;
