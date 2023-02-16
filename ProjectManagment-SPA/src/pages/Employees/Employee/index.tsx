import { Divider, Grid, List, ListItem, ListItemText } from "@mui/material";
import React, { useCallback, useEffect, useMemo, useState } from "react";
import { useParams } from "react-router-dom";
import MainCard from "../../../components/customizeComponents/MainCard";
import { getEmployeeById } from "../../../store/employeesSlice";
import { useAppDispatch, useAppSelector } from "../../../store/hooks";
import { EmployeeTimeSheetDataTable } from "../../../components/Employees/EmployeeTimeSheetDataTable";
import ProfileTap from "../../../components/Employees/ProfileTap";
import FilterTap from "../../../components/Employees/FilterTap";
import {
  getAllRecords,
  getEmployeeRecords,
  getMafreaot,
} from "../../../store/recordsSlice";
import dayjs from "dayjs";
import getDaysOfMonth from "../../../helpers/getDaysOfMonth";
import DownloadTimeSheetAsPdf from "../../../components/Employees/DownloadTimeSheetAsPdf";
import { Box } from "@mui/system";
import CurrencyFormat from "react-currency-format";
import { msg } from "../../../store/snackBardSlice";
import MafreaotDataTable from "../../../components/Reports/MafreaotDataTable";
import { IMafrea } from "../../../_interfaces/mafrea.interfac";

export interface IdataTable {
  date: string;
  dailyWage: string;
  projectId: null;
  duration: string;
  employeeId: string;
  endAt: null;
  firstName: string;
  id: string;
  lastName: string;
  notes: string;
  payPerDay: string;
  startAt: null;
  wageFrom: null;
}
const Employee = () => {
  let { id } = useParams();
  const { employee, isLoading } = useAppSelector((state) => state.employee);
  const { records, record, isLoadingRecords, mafreaot } = useAppSelector(
    (state) => state.records
  );
  const [dailyWageOfSameMonth, setDailyWageOfSameMonth] = useState(0);
  const dispatch = useAppDispatch();

  const [month, setMonth] = useState(dayjs().format("YYYY-MM-DD HH:mm:ss"));

  useEffect(() => {
    console.log("first dispatch");
    dispatch(
      getEmployeeById({
        employeeId: Number(id),
      })
    )
      .unwrap()
      .catch((error) => dispatch(msg({ msg: error, type: "error" })));
    dispatch(
      getAllRecords({
        recordsPerPage: 0,
        currentPage: 1,
        month: month,
        employeeId: Number(id),
      })
    )
      .unwrap()
      .catch((error) => dispatch(msg({ msg: error, type: "error" })));
    dispatch(
      getMafreaot({
        recordsPerPage: 50,
        currentPage: 1,
        month: month,
        employeeId: Number(id),
      })
    )
      .unwrap()
      .catch((error: any) => dispatch(msg({ msg: error, type: "error" })));
  }, [dispatch, month]);

  useEffect(() => {
    mergeWorkedDaysWithMonth();
  }, [records, month]);

  async function mergeWorkedDaysWithMonth() {
    const getTableData = getDaysOfMonth(
      dayjs(month).year(),
      dayjs(month).month() + 1
    );
    if (records.length > 0) {
      getTableData.map((day, index) => {
        const dailyWork = records.find((rec: any) => {
          rec.dailyWage
            ? setDailyWageOfSameMonth(rec.dailyWage)
            : employee && employee.dailyWage;
          if (dayjs(rec.date).isSame(day.date)) {
            return getTableData.splice(index, 1, rec);
          }
        });
      });
    }
    dispatch(getEmployeeRecords(getTableData));
  }

  const handelFilterDate = useCallback(
    (e: any) => {
      setMonth(dayjs(e).format("YYYY-MM-DD HH:mm:ss"));
    },
    [month]
  );

  const MafreaotDataTableMemo = useMemo(
    () => <MafreaotDataTable data={mafreaot} />,
    [mafreaot]
  );

  const TimesheetMemo = useMemo(
    () => <EmployeeTimeSheetDataTable records={record} employee={employee} />,
    [record]
  );

  return (
    <>
      {isLoading
        ? "loading..."
        : employee != undefined && (
            <Grid container spacing={3}>
              <Grid item xs={12} sm={5} md={4} lg={3}>
                <Grid container spacing={3}>
                  <Grid item xs={12}>
                    <ProfileTap employee={employee} />
                  </Grid>
                  <Grid item xs={12}>
                    <FilterTap handelDateValueChanged={handelFilterDate} />
                  </Grid>
                  <Grid item xs={12}>
                    <DownloadTimeSheetAsPdf
                      employeeData={employee}
                      currentMonth={month}
                      monthDays={record}
                      disable={records.length == 0 ? true : false}
                    />
                  </Grid>
                  <Grid item xs={12}>
                    <MainCard title="סיכום שעות">
                      <List
                        sx={{
                          width: "100%",
                          maxWidth: 360,
                          bgcolor: "background.paper",
                        }}
                      >
                        <Divider />

                        <ListItem
                          key={"שעות "}
                          disableGutters
                          secondaryAction={
                            record ? (
                              <Box>
                                {parseFloat(
                                  record
                                    .map((t: IdataTable) => t.duration)
                                    .reduce(
                                      (acc: number, value: number) =>
                                        acc + Number(value),
                                      0
                                    )
                                ).toFixed(2)}
                              </Box>
                            ) : (
                              0
                            )
                          }
                        >
                          <ListItemText primary={"סך הכל ש״ע"} />
                        </ListItem>
                        <Divider />

                        <ListItem
                          key={"שכר יומי"}
                          disableGutters
                          secondaryAction={
                            dailyWageOfSameMonth && (
                              <CurrencyFormat
                                value={dailyWageOfSameMonth}
                                displayType={"text"}
                                thousandSeparator={true}
                                prefix={"₪"}
                              />
                            )
                          }
                        >
                          <ListItemText primary={"שכר יומי"} />
                        </ListItem>
                        <Divider />
                        <ListItem
                          key={"מפריעות הכל"}
                          disableGutters
                          secondaryAction={
                            mafreaot ? (
                              <CurrencyFormat
                                value={mafreaot
                                  .map((t: IMafrea) => t.amount)
                                  .reduce(
                                    (acc: number, value: number) =>
                                      acc + Number(value),
                                    0
                                  )}
                                displayType={"text"}
                                thousandSeparator={true}
                                prefix={"₪"}
                              />
                            ) : (
                              0
                            )
                          }
                        >
                          <ListItemText primary={"סך הכל מפריעות "} />
                        </ListItem>

                        <Divider />
                        <ListItem
                          key={"בסך הכל"}
                          disableGutters
                          secondaryAction={
                            record ? (
                              <CurrencyFormat
                                value={record
                                  .map((t: IdataTable) => t.payPerDay)
                                  .reduce(
                                    (acc: number, value: number) =>
                                      acc + Number(value),
                                    0
                                  )}
                                displayType={"text"}
                                thousandSeparator={true}
                                prefix={"₪"}
                              />
                            ) : (
                              0
                            )
                          }
                        >
                          <ListItemText primary={"סך הכל משכורת "} />
                        </ListItem>

                        <Divider />
                      </List>
                    </MainCard>
                  </Grid>
                </Grid>
              </Grid>
              <Grid item xs={12} sm={7} md={8} lg={9}>
                <Grid container>
                  <Grid item xs={12}>
                    <MainCard title="טבלת שעות עבודה" sx={{ overflow: "auto" }}>
                      {isLoadingRecords
                        ? "טוען שעות עבודה"
                        : record && record.length > 0 && TimesheetMemo}
                      <Divider />
                      <Grid
                        container
                        justifyContent="flex-end"
                        pt={2}
                        spacing={2}
                      >
                        <Grid item xs={12}>
                          <MainCard title={"מפריעות"}>
                            {MafreaotDataTableMemo}
                          </MainCard>
                        </Grid>
                      </Grid>
                    </MainCard>
                  </Grid>
                </Grid>
              </Grid>
            </Grid>
          )}
    </>
  );
};

export default Employee;
