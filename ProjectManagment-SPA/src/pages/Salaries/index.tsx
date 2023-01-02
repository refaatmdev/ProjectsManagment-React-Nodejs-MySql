import React, { useCallback, useEffect, useState } from "react";
import {
  Box,
  Button,
  Grid,
  Pagination,
  Typography,
  TextField,
  Stack,
  Divider,
} from "@mui/material";
import MainCard from "../../components/customizeComponents/MainCard";
import theme from "../../theme/theme";
import AttachMoneyIcon from "@mui/icons-material/AttachMoney";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";
import dayjs from "dayjs";
import {
  calculateSalary,
  getAllSalaries,
  getSalaryByMonth,
} from "../../store/recordsSlice";
import { useAppDispatch, useAppSelector } from "../../store/hooks";
import SalariesDataTable from "../../components/Salaries/SalariesDataTable";
import { msg } from "../../store/snackBardSlice";
const Salaries = () => {
  const { salaries, employeeSalaries, isLoadingSalaries } = useAppSelector(
    (state) => state.records
  );
  const dispatch = useAppDispatch();

  const [calculateMonth, setCalculateMonth] = useState(dayjs().format());
  const [salariesMonth, setSalariesMonth] = useState(dayjs().format());

  useEffect(() => {
    dispatch(getAllSalaries());
    dispatch(getSalaryByMonth({ month: salariesMonth }));
    console.log(salaries);
  }, [dispatch]);

  const handelDateValueChangedCalculate = useCallback(
    (e: any) => {
      setCalculateMonth(dayjs(e).format("YYYY-MM-DD HH:mm:ss"));
    },
    [calculateMonth]
  );

  const handelDateValueChangedSalaries = useCallback(
    (e: any) => {
      setSalariesMonth(dayjs(e).startOf("month").format("YYYY-MM-DD HH:mm:ss"));
    },
    [salariesMonth]
  );

  const handelCalaculateSalaries = () => {
    dispatch(calculateSalary(calculateMonth))
      .unwrap()
      .then(() => {
        dispatch(getAllSalaries());
        dispatch(msg({ msg: "עיבוד דיווחות בוצע בהצלחה", type: "success" }));
      });
  };

  const handelShowSalarie = useCallback(() => {
    dispatch(getSalaryByMonth({ month: salariesMonth }));
  }, [salariesMonth]);

  return (
    <>
      <Grid container rowSpacing={4.5} columnSpacing={3}>
        {/* <Grid container spacing={3}> */}
        <Grid item xs={12} lg={6} md={6}>
          <MainCard
            title="עיבוד משכורות"
            mainColor={theme.palette.error.light}
            secondary={<AttachMoneyIcon fontSize="small" />}
            contentSX={{ display: "flex", justifyContent: "center" }}
          >
            <Stack spacing={2} width={"100%"}>
              <Typography>נא לבחור חודש לעיבוד</Typography>
              <Divider />
              <LocalizationProvider
                dateAdapter={AdapterDayjs}
                styles={{ width: "100%" }}
              >
                <DatePicker
                  openTo="month"
                  views={["year", "month"]}
                  label="בחר תאריך"
                  value={calculateMonth}
                  onChange={(e) => handelDateValueChangedCalculate(e)}
                  renderInput={(params) => (
                    <TextField {...params} helperText={null} />
                  )}
                />
              </LocalizationProvider>
              <Button onClick={handelCalaculateSalaries}>בצע עיבוד </Button>
            </Stack>
          </MainCard>
        </Grid>
        <Grid item xs={12} lg={6} md={6}>
          <MainCard
            title="הצגת משכורות"
            mainColor={theme.palette.error.light}
            secondary={<AttachMoneyIcon fontSize="small" />}
            contentSX={{ display: "flex", justifyContent: "center" }}
          >
            <Stack spacing={2} width={"100%"}>
              <Typography>נא לבחור חודש להצגה</Typography>
              <Divider />
              <LocalizationProvider
                dateAdapter={AdapterDayjs}
                styles={{ width: "100%" }}
              >
                <DatePicker
                  openTo="month"
                  views={["year", "month"]}
                  label="בחר תאריך"
                  value={salariesMonth}
                  onChange={(e) => handelDateValueChangedSalaries(e)}
                  renderInput={(params) => (
                    <TextField {...params} helperText={null} />
                  )}
                />
              </LocalizationProvider>

              <Button onClick={handelShowSalarie}>הצג משכורות</Button>
            </Stack>
          </MainCard>
        </Grid>
        {/* <Grid
          item
          md={8}
          sx={{ display: { sm: "none", md: "block", lg: "none" } }}
        /> */}

        {/* </Grid> */}
        {/* <Grid container spacing={3}> */}
        <Grid item xs={12} md={4}>
          <MainCard
            title="סיכום משכורות"
            mainColor={theme.palette.warning.light}
            secondary={<AttachMoneyIcon fontSize="small" />}
            contentSX={{ display: "flex", justifyContent: "center" }}
          >
            {salaries && <SalariesDataTable path="Salaries" data={salaries} />}
          </MainCard>
        </Grid>
        <Grid item xs={12} md={8}>
          <MainCard
            title="משכורות לחודש"
            mainColor={theme.palette.primary.light}
            secondary={<AttachMoneyIcon fontSize="small" />}
            contentSX={{ display: "flex", justifyContent: "center" }}
          >
            {employeeSalaries && (
              <SalariesDataTable path="Employees" data={employeeSalaries} />
            )}
          </MainCard>
          {/* </Grid> */}
        </Grid>
      </Grid>
    </>
  );
};

export default Salaries;
