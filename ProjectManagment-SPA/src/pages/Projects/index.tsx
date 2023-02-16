import {
  Box,
  Grid,
  IconButton,
  InputBase,
  Pagination,
  Stack,
} from "@mui/material";
import React, {
  ChangeEvent,
  useCallback,
  useEffect,
  useMemo,
  useState,
} from "react";
import MainCard from "../../components/customizeComponents/MainCard";
import { useAppDispatch, useAppSelector } from "../../store/hooks";
import theme from "../../theme/theme";
import AddCircleOutlineIcon from "@mui/icons-material/AddCircleOutline";
import { getProjects } from "../../store/projectsSlice";
import { msg } from "../../store/snackBardSlice";
import ProjectsDataTable from "../../components/Projects/ProjectsDataTable";
import ProjejctAction from "../../components/Projects/ProjejctAction";
import { IProject } from "../../_interfaces/project.interface";

function Projects() {
  const { isLoading, projectsDataTable, totalProjects } = useAppSelector(
    (state) => state.projects
  );
  const dispatch = useAppDispatch();
  const [selectedProject, setSelectedProject] = useState<IProject>();
  const ITEMS_PER_PAGE = 10;
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [searchValue, setSearchValue] = useState<string>("");
  const [show, setShow] = useState(false);
  const handleClose = useCallback(() => {
    setShow(false);
    setSelectedProject(undefined);
  }, [show]);

  useEffect(() => {
    dispatch(
      getProjects({
        projectsPerPage: ITEMS_PER_PAGE,
        currentPage: currentPage,
        searchValue: searchValue,
      })
    )
      .unwrap()
      .catch((error) => dispatch(msg({ msg: error, type: "error" })));
  }, [dispatch, currentPage, searchValue]);

  const openEditModal = (data: IProject) => {
    setShow(true);
    setSelectedProject(data);
  };
  const projectsDataTableMemo = useMemo(
    () => (
      <ProjectsDataTable
        openEditModal={openEditModal}
        data={projectsDataTable}
        ITEMS_PER_PAGE={ITEMS_PER_PAGE}
        currentPage={currentPage}
      />
    ),
    [projectsDataTable]
  );

  const handleChangePage = (event: unknown, page: number) => {
    setCurrentPage((prev) => (prev = page));
  };

  const handelSearchValueChanged = useCallback(
    (e: ChangeEvent<HTMLInputElement>) => {
      e.preventDefault();
      setSearchValue(e.target.value);
    },
    [searchValue]
  );

  return (
    <>
      <Grid container>
        <Grid container direction="column">
          <Grid item sx={{ marginBottom: "1rem" }}></Grid>
        </Grid>
      </Grid>
      <Grid container spacing={2} sx={{ my: 1 }}>
        <Grid container spacing={2}>
          <Grid item xs={12} md={6} lg={4}>
            <MainCard
              title={
                <Stack direction="row" justifyContent="space-between">
                  <Box>סך הכל פרוייקטים</Box>
                  {totalProjects}
                  <Box></Box>
                </Stack>
              }
              mainColor={theme.palette.primary.light}
              border={false}
              content={false}
            ></MainCard>
          </Grid>
          <Grid item xs={12} md={6} lg={4}>
            <MainCard
              title={
                <Stack direction="row" justifyContent="space-between">
                  <Box> סך הכל פרוייקטים פעילים</Box>
                  {totalProjects}
                  <Box></Box>
                </Stack>
              }
              mainColor={theme.palette.success.light}
              border={false}
              content={false}
            ></MainCard>
          </Grid>
          <Grid item xs={12} md={6} lg={4}>
            <MainCard
              title={
                <Stack direction="row" justifyContent="space-between">
                  <Box>סך הכל פרוייקטים שהסתיימו</Box>
                  {totalProjects}
                  <Box></Box>
                </Stack>
              }
              mainColor={theme.palette.error.light}
              border={false}
              content={false}
            ></MainCard>
          </Grid>
        </Grid>

        <Grid item xs={12}>
          <MainCard
            mainColor={theme.palette.primary.light}
            content={false}
            title="רשימת פרוייקטים"
            sx={{ my: 5, overflow: "auto" }}
            secondary={
              <IconButton onClick={(prev) => setShow(true)}>
                <AddCircleOutlineIcon sx={{ color: "white" }} />
              </IconButton>
            }
          >
            <Box sx={{ with: "100%", padding: "10px 10px" }}>
              <InputBase
                placeholder="הכנס שם פרויקט"
                onChange={handelSearchValueChanged}
              />
            </Box>

            {isLoading ? (
              "loading..."
            ) : (
              <Box
                sx={{ width: "100%", display: "table", tableLayout: "fixed" }}
              >
                {projectsDataTable.length > 0
                  ? projectsDataTableMemo
                  : "אין עובדים..."}
                <Box display="flex" justifyContent="center">
                  <Pagination
                    count={Math.ceil(totalProjects / ITEMS_PER_PAGE)}
                    page={currentPage}
                    onChange={handleChangePage}
                  />
                </Box>
              </Box>
            )}
          </MainCard>
        </Grid>
      </Grid>
      <ProjejctAction
        show={show}
        handelClose={handleClose}
        data={selectedProject}
      />
    </>
  );
}

export default Projects;
