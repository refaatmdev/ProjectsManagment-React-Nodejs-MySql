import { Box, Button, Grid, Pagination } from "@mui/material";
import React, { useCallback, useEffect, useMemo, useState } from "react";
import MainCard from "../../components/customizeComponents/MainCard";
import theme from "../../theme/theme";
import NoteAddIcon from "@mui/icons-material/NoteAdd";
import AddReports from "../../components/Reports/AddReports";
import dayjs from "dayjs";
import { useAppDispatch, useAppSelector } from "../../store/hooks";
import { getAllRecords, getMafreaot } from "../../store/recordsSlice";
import { EmployeeTimeSheetDataTable } from "../../components/Employees/EmployeeTimeSheetDataTable";
import MoneyOffIcon from "@mui/icons-material/MoneyOff";
import EmployeeAction from "../../components/Employees/EmployeeAction";
import FilterTap from "../../components/Employees/FilterTap";
import MafreaotDataTable from "../../components/Reports/MafreaotDataTable";
const Reports = () => {
  const {
    totalRecords,
    records,
    isLoadingRecords,
    mafreaot,
    isLoadingMafreaot,
  } = useAppSelector((state) => state.records);
  const dispatch = useAppDispatch();

  const [open, setOpen] = useState(false);
  const [currentMonth, setCurrentMonth] = useState(
    dayjs().format("YYYY-MM-DD")
  );

  const ITEMS_PER_PAGE = 50;
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [show, setShow] = useState(false);
  const handleClose = useCallback(() => setShow(false), [show]);
  const [month, setMonth] = useState(dayjs().format("YYYY-MM-DD"));
  useEffect(() => {
    dispatch(
      getAllRecords({
        recordsPerPage: ITEMS_PER_PAGE,
        currentPage: currentPage,
        month: currentMonth,
      })
    );
    dispatch(
      getMafreaot({
        recordsPerPage: ITEMS_PER_PAGE,
        currentPage: currentPage,
        month: currentMonth,
      })
    );
  }, [dispatch, currentMonth, currentPage]);

  const handelClose = useCallback(() => {
    setOpen(false);
  }, [open]);

  const TimesheetMemo = useMemo(
    () => <EmployeeTimeSheetDataTable records={records} employee={null} />,
    [records]
  );

  const MafreaotDataTableMemo = useMemo(
    () => <MafreaotDataTable data={mafreaot} />,
    [mafreaot]
  );

  const handelFilterDate = useCallback(
    (e: any) => {
      setCurrentMonth(dayjs(e).format("YYYY-MM-DD HH:mm:ss"));
    },
    [currentMonth]
  );

  const handleChangePage = (event: unknown, page: number) => {
    setCurrentPage((prev) => (prev = page));
  };

  const reportActionMemo = useMemo(
    () => <AddReports open={open} handelClose={handelClose} />,
    [open]
  );

  const mafreaActionMemo = useMemo(
    () => (
      <EmployeeAction
        handleClose={handleClose}
        show={show}
        type="addARiot"
        headTitle="עדכון מפרעה לעובד"
      />
    ),
    [show]
  );
  return (
    <>
      <Grid container spacing={3}>
        <Grid item xs={12} sm={5} md={4} lg={3}>
          <Grid container spacing={3}>
            <Grid item xs={12}>
              {/* <ProfileTap employee={employee} /> */}
              <MainCard
                title=" הוספת דיווח חדש"
                mainColor={theme.palette.success.light}
                secondary={<NoteAddIcon fontSize="small" />}
                contentSX={{ display: "flex", justifyContent: "center" }}
              >
                <Button variant="contained" onClick={() => setOpen(!open)}>
                  הוספת דיווח
                </Button>
              </MainCard>
            </Grid>
            <Grid item xs={12}>
              <MainCard
                title=" מפרעות"
                mainColor={theme.palette.error.light}
                secondary={<MoneyOffIcon fontSize="small" />}
                //   border={false}
                //   content={false}
                contentSX={{ display: "flex", justifyContent: "center" }}
              >
                <Button variant="contained" onClick={() => setShow(true)}>
                  הוספת מפרעה
                </Button>
                {show && mafreaActionMemo}
              </MainCard>
            </Grid>
            <Grid item xs={12}>
              <FilterTap
                handelDateValueChanged={handelFilterDate}
                value={currentMonth}
              />
            </Grid>
          </Grid>
        </Grid>
        <Grid item xs={12} sm={7} md={8} lg={9}>
          <Grid container>
            <Grid item xs={12}>
              <MainCard title="טבלת שעות עבודה" sx={{ overflow: "auto" }}>
                {isLoadingRecords
                  ? "טוען שעות עבודה"
                  : records && TimesheetMemo}
                <Box display="flex" justifyContent="center">
                  <Pagination
                    count={Math.ceil(totalRecords / ITEMS_PER_PAGE)}
                    page={currentPage}
                    onChange={handleChangePage}
                  />
                </Box>
              </MainCard>
            </Grid>
            <Grid container>
              <Grid item xs={12}>
                <MainCard title="טבלת מפריעות" sx={{ overflow: "auto", mt: 2 }}>
                  {isLoadingMafreaot
                    ? "טוען מפריעות"
                    : records && MafreaotDataTableMemo}
                </MainCard>
              </Grid>
            </Grid>
          </Grid>
        </Grid>
        {/* <Grid item xs={12} sm={7} md={8} lg={9}>
          
        </Grid> */}
      </Grid>
      {reportActionMemo}
    </>
  );
};

export default Reports;
