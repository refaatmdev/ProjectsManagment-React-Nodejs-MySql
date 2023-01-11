import React, { useCallback, useEffect, useMemo, useState } from "react";
import { useParams } from "react-router-dom";
import { useAppDispatch, useAppSelector } from "../../../store/hooks";
import {
  deleteProjectNotes,
  deleteProjectPaid,
  deleteQuotation,
  getProjectById,
  getProjectNotes,
  getProjectPaids,
} from "../../../store/projectsSlice";
import { msg } from "../../../store/snackBardSlice";
import {
  Grid,
  IconButton,
  List,
  Stack,
  Tooltip,
  Typography,
} from "@mui/material";
import MainCard from "../../../components/customizeComponents/MainCard";
import ProjectTap from "../../../components/Projects/ProjectTap";
import { getRecordsByProject } from "../../../store/recordsSlice";
import ProjectDataTable from "../../../components/Projects/ProjectDataTable";
import { BASE_URL } from "../../../config";
import { DeleteOutlined } from "@mui/icons-material";
import ButtonBase from "@mui/material/ButtonBase";
import { styled } from "@mui/material/styles";
import { QuotationDetailsModal } from "../../../components/Projects/QuotationDetailsModal";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import {
  IProject,
  IProjectNotes,
} from "../../../_interfaces/project.interface";
import ProjectNotes from "../../../components/Projects/ProjectNotes";
import AddBoxOutlinedIcon from "@mui/icons-material/AddBoxOutlined";
import ProjejctNotesAction from "../../../components/Projects/ProjejctNotesAction";
import dayjs from "dayjs";
import ProjectPaids from "../../../components/Projects/ProjectPaids";
import { IPaids } from "../../../_interfaces/paids.interface";
import ProjectPaidsAction from "../../../components/Projects/ProjectPaidsAction";
const MySwal = withReactContent(Swal);

const ImageButton = styled(ButtonBase)(({ theme }) => ({
  position: "relative",
  height: 200,
  [theme.breakpoints.down("sm")]: {
    width: "100% !important", // Overrides inline-style
    height: 100,
  },
  "&:hover, &.Mui-focusVisible": {
    zIndex: 1,
    "& .MuiImageBackdrop-root": {
      opacity: 0.15,
    },
    "& .MuiImageMarked-root": {
      opacity: 0,
    },
    "& .MuiTypography-root": {
      border: "4px solid currentColor",
    },
  },
}));

const ImageSrc = styled("span")({
  position: "absolute",
  left: 0,
  right: 0,
  top: 0,
  bottom: 0,
  backgroundSize: "cover",
  backgroundPosition: "center 40%",
});

const Image = styled("span")(({ theme }) => ({
  position: "absolute",
  left: 0,
  right: 0,
  top: 0,
  bottom: 0,
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  color: theme.palette.common.white,
}));

const ImageBackdrop = styled("span")(({ theme }) => ({
  position: "absolute",
  left: 0,
  right: 0,
  top: 0,
  bottom: 0,
  backgroundColor: theme.palette.common.black,
  opacity: 0.4,
  transition: theme.transitions.create("opacity"),
}));

const ImageMarked = styled("span")(({ theme }) => ({
  height: 3,
  width: 18,
  backgroundColor: theme.palette.common.white,
  position: "absolute",
  bottom: -2,
  left: "calc(50% - 9px)",
  transition: theme.transitions.create("opacity"),
}));

const Project = () => {
  let { id } = useParams();
  const dispatch = useAppDispatch();
  const { project, projectNotes, projectPaids, isLoading } = useAppSelector(
    (state) => state.projects
  );
  const { projectRecordsDataTable } = useAppSelector((state) => state.records);

  const [open, setOpen] = useState<boolean>(false);
  const [openNoteAction, setOpenNoteAction] = useState<boolean>(false);
  const [openPaidsAction, setOpenPaidsAction] = useState<boolean>(false);
  const [selectedPaid, setSelectedPaid] = useState<IPaids | undefined>(
    undefined
  );
  const [selectedNote, setSelectedNote] = useState<IProjectNotes | undefined>(
    undefined
  );
  const handleClose = () => setOpen(false);
  const handelCloseNoteAction = () => {
    setOpenNoteAction(false), setSelectedNote(undefined);
  };

  const handelClosePaidsAction = () => {
    setOpenPaidsAction(false), setSelectedPaid(undefined);
  };
  useEffect(() => {
    dispatch(getProjectById({ projectId: Number(id) }))
      .unwrap()
      .catch((error) => {
        dispatch(msg({ msg: error.message, type: "error" }));
      });
    dispatch(getRecordsByProject({ projectId: Number(id) }))
      .unwrap()
      .catch((error) => {
        dispatch(msg({ msg: error.message, type: "error" }));
      });
    dispatch(getProjectNotes({ projectId: Number(id) }))
      .unwrap()
      .catch((error) => {
        dispatch(msg({ msg: error.message, type: "error" }));
      });
    dispatch(getProjectPaids({ projectId: Number(id) }))
      .unwrap()
      .catch((error) => {
        dispatch(msg({ msg: error.message, type: "error" }));
      });
  }, [id]);

  const handelDeleteQuotation = useCallback(
    (data: IProject) => {
      MySwal.fire({
        title: `האם אתה בטוח שרוצה למחוק את ההסכם של ${data.projectName}?`,
        text: "לא תוכל לשחזר או לבטל את הפעולה",
        icon: "error",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "כן, מחק!",
        cancelButtonText: "בטל",
      }).then((result) => {
        if (result.isConfirmed) {
          dispatch(deleteQuotation({ projectId: Number(data.id) })).then(() =>
            dispatch(getProjectById({ projectId: Number(id) }))
              .unwrap()
              .catch((error) => {
                dispatch(msg({ msg: error.message, type: "error" }));
              })
          );
          MySwal.fire({
            title: "נמחק!",
            text: `  הסכם של פרויקט ${data.projectName} נמחק`,
            icon: "success",
            confirmButtonText: "תודה!",
          });
        }
      });
    },
    [dispatch]
  );

  const TimesheetMemo = useMemo(
    () => <ProjectDataTable records={projectRecordsDataTable} />,
    [projectRecordsDataTable]
  );
  const handelDeletePaid = useCallback((data: IPaids) => {
    MySwal.fire({
      title: `האם אתה בטוח שרוצה למחוק תשלום שבתאריך ${dayjs(
        data.paidDate
      ).format("YYYY-MM-DD HH:MM")}?`,
      text: "לא תוכל לשחזר או לבטל את הפעולה",
      icon: "error",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "כן, מחק!",
      cancelButtonText: "בטל",
    }).then((result) => {
      if (result.isConfirmed) {
        dispatch(deleteProjectPaid(data)).then(() =>
          dispatch(getProjectPaids({ projectId: Number(id) }))
        );
        MySwal.fire({
          title: "נמחק!",
          text: `  תשלום שבתאריך ${dayjs(data.createdAt).format(
            "YYYY-MM-DD"
          )} נמחק`,
          icon: "success",
          confirmButtonText: "תודה!",
        });
      }
    });
  }, []);
  const PaidsTableMemo = useMemo(
    () => (
      <ProjectPaids
        paids={projectPaids}
        setSelectedPaid={setSelectedPaid}
        setOpenPaidsAction={setOpenPaidsAction}
        handelDeletePaid={handelDeletePaid}
      />
    ),
    [projectPaids]
  );

  const handelUpdateNote = useCallback(
    (data: IProjectNotes) => {
      setOpenNoteAction(true);
      setSelectedNote(data);
    },
    [selectedNote != undefined]
  );

  const handelDeleteNote = useCallback((data: IProjectNotes) => {
    MySwal.fire({
      title: `האם אתה בטוח שרוצה למחוק את  ההערה שבתאריך ${dayjs(
        data.createdAt
      ).format("YYYY-MM-DD HH:MM")}?`,
      text: "לא תוכל לשחזר או לבטל את הפעולה",
      icon: "error",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "כן, מחק!",
      cancelButtonText: "בטל",
    }).then((result) => {
      if (result.isConfirmed) {
        dispatch(deleteProjectNotes(data)).then(() =>
          dispatch(getProjectNotes({ projectId: Number(id) }))
            .unwrap()
            .catch((error) => {
              dispatch(msg({ msg: error.message, type: "error" }));
            })
        );
        MySwal.fire({
          title: "נמחק!",
          text: `  הערכה שבתאריך ${dayjs(data.createdAt).format(
            "YYYY-MM-DD HH:MM"
          )} נמחק`,
          icon: "success",
          confirmButtonText: "תודה!",
        });
      }
    });
  }, []);

  const ProjectNotesMemo = useMemo(
    () => (
      <ProjectNotes
        projectNotes={projectNotes}
        handelUpdateNote={handelUpdateNote}
        handelDeleteNote={handelDeleteNote}
      />
    ),
    [projectNotes]
  );
  return (
    <>
      {isLoading
        ? "loading..."
        : project != undefined && (
            <Grid container spacing={3}>
              <Grid item xs={12} sm={5} md={4} lg={3}>
                <Grid container spacing={3}>
                  <Grid item xs={12}>
                    <ProjectTap project={project} />
                  </Grid>

                  {project.agreement && (
                    <Grid item xs={12}>
                      <MainCard
                        title="הסכם עבודה"
                        secondary={
                          <Tooltip title="מחק הסכם">
                            <IconButton
                              color="error"
                              size="large"
                              onClick={() => handelDeleteQuotation(project)}
                            >
                              <DeleteOutlined />
                            </IconButton>
                          </Tooltip>
                        }
                      >
                        <ImageButton
                          focusRipple
                          key={project.projectName}
                          style={{
                            width: "100%",
                          }}
                          onClick={() => setOpen(true)}
                        >
                          <ImageSrc
                            style={{
                              backgroundImage: `url(${BASE_URL}/${project.agreement})`,
                            }}
                          />
                          <ImageBackdrop className="MuiImageBackdrop-root" />
                          <Image>
                            <Typography
                              component="span"
                              variant="subtitle1"
                              color="inherit"
                              sx={{
                                position: "relative",
                                p: 4,
                                pt: 2,
                                pb: (theme) =>
                                  `calc(${theme.spacing(1)} + 6px)`,
                              }}
                            >
                              להצגת הסכם
                              <ImageMarked className="MuiImageMarked-root" />
                            </Typography>
                          </Image>
                        </ImageButton>
                      </MainCard>
                    </Grid>
                  )}
                  <Grid item xs={12}>
                    <MainCard
                      secondary={
                        <IconButton
                          color="primary"
                          size="large"
                          onClick={() => {
                            setSelectedNote(undefined), setOpenNoteAction(true);
                          }}
                        >
                          <AddBoxOutlinedIcon />
                        </IconButton>
                      }
                      title="הערות"
                    >
                      {ProjectNotesMemo}
                    </MainCard>
                  </Grid>
                </Grid>
              </Grid>
              <Grid item xs={12} sm={7} md={8} lg={9}>
                <Grid
                  container
                  alignItems="center"
                  justifyContent="space-between"
                >
                  <Grid item>
                    <Stack
                      direction="row"
                      spacing={1.5}
                      justifyContent="center"
                      alignItems="center"
                    >
                      <Typography variant="h5">תשלומים</Typography>
                      <IconButton
                        color="primary"
                        size="large"
                        onClick={() => {
                          setSelectedPaid(undefined), setOpenPaidsAction(true);
                        }}
                      >
                        <AddBoxOutlinedIcon />
                      </IconButton>
                    </Stack>
                  </Grid>
                </Grid>
                <MainCard sx={{ mt: 2 }} content={false}>
                  {PaidsTableMemo}
                </MainCard>
                <Grid item />
                <Grid
                  container
                  alignItems="center"
                  justifyContent="space-between"
                >
                  <Grid item>
                    <Typography variant="h5" pt={2}>
                      טבלת שעות עבודה
                    </Typography>
                  </Grid>
                </Grid>
                <MainCard sx={{ mt: 2 }} content={false}>
                  {TimesheetMemo}
                </MainCard>
              </Grid>
            </Grid>
          )}
      {project && project.agreement != null && open && (
        <QuotationDetailsModal
          open={open}
          data={project}
          handleClose={handleClose}
        />
      )}
      {project && openNoteAction && (
        <ProjejctNotesAction
          data={selectedNote != undefined ? selectedNote : undefined}
          projectId={project.id}
          show={openNoteAction}
          handelClose={handelCloseNoteAction}
        />
      )}
      {project && openPaidsAction && (
        <ProjectPaidsAction
          projectId={project.id}
          data={selectedPaid != undefined ? selectedPaid : undefined}
          show={openPaidsAction}
          handelClose={handelClosePaidsAction}
        />
      )}
    </>
  );
};

export default Project;
