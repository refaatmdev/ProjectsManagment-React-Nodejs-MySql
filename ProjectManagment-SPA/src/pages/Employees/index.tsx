import styled from "@emotion/styled";
import {
  Button,
  Grid,
  Pagination,
  Stack,
  TablePagination,
  Typography,
} from "@mui/material";
import { Box } from "@mui/system";
import React, {
  ChangeEvent,
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import MainCard from "../../components/customizeComponents/MainCard";
import EmployeeAction from "../../components/Employees/EmployeeAction";
import EmployeesDataTable from "../../components/Employees/EmployeesDataTable";
import FilterEmployees from "../../components/Employees/FilterEmployees";
import { getEmployees } from "../../store/employeesSlice";
import { useAppDispatch, useAppSelector } from "../../store/hooks";
import theme from "../../theme/theme";
import PeopleIcon from "@mui/icons-material/People";
import PersonOffIcon from "@mui/icons-material/PersonOff";
import PeopleOutlineIcon from "@mui/icons-material/PeopleOutline";
import { msg } from "../../store/snackBardSlice";

const Search = styled("div")(({ theme }) => ({
  with: "100%",
  padding: "10px 10px",
}));

const Employees = () => {
  const {
    isLoading,
    employees,
    employeeDataTable,
    totalEmployees,
    activeEmployees,
  } = useAppSelector((state) => state.employee);
  const dispatch = useAppDispatch();

  const ITEMS_PER_PAGE = 10;
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [searchValue, setSearchValue] = useState<string>("");
  const [show, setShow] = useState(false);
  const [type, setType] = useState("");
  const [notActive, setNotAtive] = useState(0);
  // const shouldload = useRef<boolean>(true);

  useEffect(() => {
    console.log("employees effect");
    dispatch(
      getEmployees({
        employeePerPage: ITEMS_PER_PAGE,
        currentPage: currentPage,
        searchValue: searchValue,
      })
    )
      .unwrap()
      .catch((error) => dispatch(msg({ msg: error, type: "error" })));
  }, [dispatch, currentPage, searchValue]);

  useEffect(() => {
    setNotAtive((prev) => employees.length - activeEmployees.length);
  }, [employees.length > 0]);

  const handelSearchValueChanged = useCallback(
    (e: ChangeEvent<HTMLInputElement>) => {
      e.preventDefault();
      setSearchValue(e.target.value);
    },
    [searchValue]
  );

  const handelOpenModal = useCallback(
    (t: string) => {
      setShow(true);
      setType(t);
    },
    [show]
  );
  const handleClose = useCallback(() => setShow(false), [show]);
  const handleChangePage = (event: unknown, page: number) => {
    setCurrentPage((prev) => (prev = page));
  };
  const employeeDataTableMemo = useMemo(
    () => (
      <EmployeesDataTable
        data={employeeDataTable}
        ITEMS_PER_PAGE={ITEMS_PER_PAGE}
        currentPage={currentPage}
      />
    ),
    [employeeDataTable]
  );
  return (
    <>
      <Grid container>
        <Grid container direction="column">
          <Grid item sx={{ marginBottom: "1rem" }}>
            {/* <Typography variant="h5">עובדים</Typography> */}
          </Grid>
        </Grid>
      </Grid>
      <Grid container spacing={2} sx={{ my: 1 }}>
        <Grid container spacing={2}>
          <Grid item xs={12} md={6} lg={4}>
            <MainCard
              title={
                <Stack direction="row" justifyContent="space-between">
                  <Box>סך הכל עובדים</Box>
                  {totalEmployees}
                  <Box></Box>
                </Stack>
              }
              mainColor={theme.palette.primary.light}
              secondary={<PeopleOutlineIcon fontSize="large" />}
              border={false}
              content={false}
            ></MainCard>
          </Grid>
          <Grid item xs={12} md={6} lg={4}>
            <MainCard
              title={
                <Stack direction="row" justifyContent="space-between">
                  <Box> סך הכל עובדים פעילים</Box>

                  <Box>{activeEmployees.length}</Box>
                </Stack>
              }
              mainColor={theme.palette.success.light}
              secondary={<PeopleIcon fontSize="large" />}
              border={false}
              content={false}
            ></MainCard>
          </Grid>
          <Grid item xs={12} md={6} lg={4}>
            <MainCard
              title={
                <Stack direction="row" justifyContent="space-between">
                  <Box>סך הכל עובדים לא פעילים</Box>
                  {notActive}
                  <Box></Box>
                </Stack>
              }
              mainColor={theme.palette.error.light}
              secondary={<PersonOffIcon fontSize="large" />}
              border={false}
              content={false}
            ></MainCard>
          </Grid>
        </Grid>
        <Grid item xs={12} sm={6}>
          <MainCard
            title="הוספת עובד חדש"
            contentSX={{ display: "flex", justifyContent: "center" }}
          >
            <Button
              onClick={() => {
                handelOpenModal("addEmployee");
              }}
              variant="contained"
            >
              הוספת עובד
            </Button>
            {type === "addEmployee" && show && (
              <EmployeeAction
                handleClose={handleClose}
                show={show}
                type={type}
                headTitle="הוספת עובד חדש"
              />
            )}
          </MainCard>
        </Grid>
        <Grid item xs={12} sm={6}>
          <MainCard
            title="עדכון שכר יומי"
            contentSX={{ display: "flex", justifyContent: "center" }}
          >
            <Button
              onClick={() => {
                handelOpenModal("dailyWage");
              }}
              variant="contained"
            >
              עדכון שכר
            </Button>
            {type === "dailyWage" && show && (
              <EmployeeAction
                handleClose={handleClose}
                show={show}
                type={type}
                headTitle="עדכון שכר לעובד"
              />
            )}
          </MainCard>
        </Grid>
        <Grid item xs={12}>
          <MainCard
            mainColor={theme.palette.primary.light}
            content={false}
            title="רשימת עובדים"
            sx={{ my: 5, overflow: "auto" }}
          >
            <Search>
              <FilterEmployees
                handelSearchValueChanged={handelSearchValueChanged}
              />
            </Search>
            {isLoading ? (
              "loading..."
            ) : (
              <Box
                sx={{ width: "100%", display: "table", tableLayout: "fixed" }}
              >
                {employees.length > 0 ? employeeDataTableMemo : "אין עובדים..."}
                <Box display="flex" justifyContent="center">
                  <Pagination
                    count={Math.ceil(totalEmployees / ITEMS_PER_PAGE)}
                    page={currentPage}
                    onChange={handleChangePage}
                  />
                </Box>
              </Box>
            )}
          </MainCard>
        </Grid>
      </Grid>
    </>
  );
};

export default Employees;
