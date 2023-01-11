import React from "react";
import { IProject } from "../../_interfaces/project.interface";
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
import { addNewProject, updateProject } from "../../store/projectsSlice";
import { msg } from "../../store/snackBardSlice";
import { useAppDispatch } from "../../store/hooks";
import dayjs from "dayjs";

export interface ProjectAction {
  data?: IProject;
  show: boolean;
  handelClose: () => void;
}

const ProjejctAction = ({ data, show, handelClose }: ProjectAction) => {
  const dispatch = useAppDispatch();

  const initialValues: IProject =
    data != undefined
      ? {
          id: data.id,
          projectName: data.projectName,
          clientFullName: data.clientFullName,
          clientPhone: data.clientPhone,
          location: data.location,
          createdAt: data.createdAt,
        }
      : {
          projectName: "",
          clientFullName: "",
          clientPhone: "",
          location: "",
          createdAt: "",
        };

  const validationSchema = Yup.object({
    id: Yup.number().optional(),
    projectName: Yup.string().required("שם פרוייקט חובה"),
    clientFullName: Yup.string().required("שם לקוח חובה"),
    clientPhone: Yup.number().required("מספר פלאפון חובה"),
    location: Yup.string().required("מיקום פרויקט חובה"),
    createdAt: Yup.string().optional(),
  });

  const handelOnSubmit = (project: IProject) => {
    project = {
      ...project,
      createdAt: dayjs(project.createdAt).format("YYYY-MM-DD HH:mm:ss"),
    };
    if (!project) return;
    if (data == undefined) {
      dispatch(addNewProject(project))
        .unwrap()
        .then(() => {
          dispatch(msg({ msg: "עדכון עובד בהצלחה", type: "success" }));
          handelClose();
        })
        .catch((error: any) => dispatch(msg({ msg: error, type: "error" })));
    } else {
      dispatch(updateProject(project))
        .unwrap()
        .then(() => {
          dispatch(
            msg({
              msg: `פרויקט ${data.projectName} עודכן בהצלחה`,
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
          {data ? `עריכת פרוקיט ${data.projectName}` : "הוספת פרויקט חדש"}
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
            {(formik: FormikProps<IProject>) => {
              return (
                <Form>
                  <Grid container>
                    <Grid item xs={12}>
                      <Stack
                        direction={{ xs: "column", sm: "row" }}
                        justifyContent="space-between"
                        alignItems="flex-end"
                        spacing={1}
                      >
                        {data && (
                          <FormikControl
                            control="input"
                            type="text"
                            label="ID"
                            name="id"
                            sxContent={{ display: "none" }}
                          />
                        )}
                        <FormikControl
                          control="input"
                          type="text"
                          label="שם פרויקט"
                          name="projectName"
                          fullWidth={true}
                        />
                        <FormikControl
                          control="input"
                          type="text"
                          label="שם קליניט"
                          name="clientFullName"
                          fullWidth={true}
                        />
                      </Stack>
                    </Grid>
                    <Grid item xs={12}>
                      <Stack>
                        <FormikControl
                          control="input"
                          type="text"
                          label="מספר פלאפון"
                          name="clientPhone"
                          fullWidth={true}
                        />
                      </Stack>
                    </Grid>
                    <Grid item xs={12}>
                      <Stack
                        direction={{ xs: "column", sm: "row" }}
                        justifyContent="space-between"
                        alignItems="flex-end"
                        spacing={1}
                      >
                        <FormikControl
                          control="input"
                          type="text"
                          label="מיקום"
                          name="location"
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
                      <Stack>
                        <Button
                          sx={{ mt: 1.5 }}
                          fullWidth
                          variant="outlined"
                          type="submit"
                          disabled={!formik.isValid}
                        >
                          שמור
                        </Button>
                      </Stack>
                    </Grid>
                  </Grid>
                </Form>
              );
            }}
          </Formik>
        </Box>
      </DialogContent>
      <DialogActions style={{ display: "flex" }}>
        <Button variant="outlined" color="error" onClick={handelClose}>
          ביטול
        </Button>
      </DialogActions>
    </Dialog>
  );
};

export default ProjejctAction;
