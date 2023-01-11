import React from "react";
import { IProject, IProjectNotes } from "../../_interfaces/project.interface";
import * as Yup from "yup";
import {
  Box,
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  Grid,
  Stack,
} from "@mui/material";
import { Form, Formik, FormikProps } from "formik";
import FormikControl from "../customizeComponents/FormikForm/FormikControler/FormikControl";
import {
  addNewProject,
  addProjectNotes,
  getProjectNotes,
  updateProject,
  updateProjectNotes,
} from "../../store/projectsSlice";
import { msg } from "../../store/snackBardSlice";
import { useAppDispatch } from "../../store/hooks";
import dayjs from "dayjs";

interface IProjectNoteActionProps {
  data?: IProjectNotes;
  projectId?: number;
  show: boolean;
  handelClose: () => void;
}
const ProjejctNotesAction = ({
  data,
  show,
  handelClose,
  projectId,
}: IProjectNoteActionProps) => {
  const dispatch = useAppDispatch();
  console.log(data);
  const initialValues: IProjectNotes =
    data != undefined
      ? {
          id: data.id,
          notes: data.notes,
          createdAt: data.createdAt,
        }
      : {
          notes: "",
          createdAt: dayjs().format(),
        };

  const validationSchema = Yup.object({
    id: Yup.number().optional(),
    notes: Yup.string().required("תוכן חובה"),
    createdAt: Yup.string().optional(),
  });

  const handelOnSubmit = (notes: IProjectNotes) => {
    notes = {
      ...notes,
      createdAt: dayjs(notes.createdAt).format("YYYY-MM-DD HH:mm:ss"),
      projectId: projectId ? projectId : undefined,
    };
    if (!notes) return;
    console.log(notes);
    if (data == undefined) {
      dispatch(addProjectNotes(notes))
        .unwrap()
        .then(() => {
          dispatch(msg({ msg: "עדכון הערה בהצלחה", type: "success" }));
          handelClose();
          dispatch(getProjectNotes({ projectId: Number(notes.projectId) }));
        })
        .catch((error: any) => dispatch(msg({ msg: error, type: "error" })));
    } else {
      dispatch(updateProjectNotes(notes))
        .unwrap()
        .then(() => {
          dispatch(getProjectNotes({ projectId: Number(notes.projectId) }));
          dispatch(
            msg({
              msg: `הוספתה הערה בהצלחה`,
              type: "success",
            })
          );
          handelClose();
        })
        .catch((error: any) => dispatch(msg({ msg: error, type: "error" })));
    }
  };
  return (
    <Dialog
      open={show}
      onClose={handelClose}
      aria-labelledby="alert-dialog-title"
      aria-describedby="alert-dialog-description"
    >
      {
        <DialogTitle>
          {data ? `עריכת הערה לתאריך ${data.createdAt}` : "הוספת הערה חדשה"}
        </DialogTitle>
      }
      <DialogContent>
        <Box
          maxWidth={"350px"}
          sx={{
            display: "flex",
            flexDirection: "column",
            alignItems: "center",
            marginTop: 2,
          }}
        >
          <Formik
            initialValues={initialValues}
            validationSchema={validationSchema}
            onSubmit={handelOnSubmit}
            enableReinitialize
          >
            {(formik: FormikProps<IProjectNotes>) => {
              return (
                <Form>
                  <Grid container>
                    <Grid item xs={12}>
                      <Stack
                        direction={{ xs: "column" }}
                        justifyContent="space-between"
                        alignItems="flex-end"
                        spacing={1}
                      >
                        <FormikControl
                          control="input"
                          type="text"
                          label="הערה"
                          name="notes"
                          fullWidth={true}
                        />
                        <FormikControl
                          control="datePicker"
                          type="date"
                          label="תאריך התחלה"
                          name="createdAt"
                          fullWidth={true}
                        />
                      </Stack>
                    </Grid>
                    <Grid item xs={12}>
                      <DialogActions style={{ display: "flex" }}>
                        <Button
                          variant="outlined"
                          type="submit"
                          disabled={!formik.isValid}
                        >
                          שמור
                        </Button>
                        <Button
                          variant="outlined"
                          color="error"
                          onClick={handelClose}
                        >
                          ביטול
                        </Button>
                      </DialogActions>
                    </Grid>
                  </Grid>
                </Form>
              );
            }}
          </Formik>
        </Box>
      </DialogContent>
    </Dialog>
  );
};

export default ProjejctNotesAction;
