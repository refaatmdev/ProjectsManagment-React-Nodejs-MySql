import React from "react";
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
  Typography,
} from "@mui/material";
import { Form, Formik, FormikProps } from "formik";
import FormikControl from "../customizeComponents/FormikForm/FormikControler/FormikControl";
import {
  addProjectQuotation,
  getProjectById,
  updateProjectQuotation,
} from "../../store/projectsSlice";
import { msg } from "../../store/snackBardSlice";
import { useAppDispatch } from "../../store/hooks";
import { ProjectAction } from "./ProjejctAction";
import { useTheme } from "@mui/material/styles";

const QuotationAction = ({ data, show, handelClose }: ProjectAction) => {
  const theme = useTheme();
  const dispatch = useAppDispatch();
  const FILE_SIZE = 5000 * 1024;
  const SUPPORTED_FORMATS = [
    "image/jpg",
    "image/jpeg",
    "image/gif",
    "image/png",
  ];

  const initialValues: {
    quotation: number | undefined;
    file?: File | null;
    quotationNotes?: string;
  } =
    data && data.quotation != null
      ? {
          quotation: data.quotation,
          file: data.agreement,
          quotationNotes: data.quotationNotes,
        }
      : { quotation: undefined, file: null, quotationNotes: "" };

  const validationSchema = Yup.object({
    quotation: Yup.number().required("סכום חובה"),
    file: Yup.mixed()
      .nullable()
      .test("fileSize", "הקובץ גדול מדי", (value: File) =>
        value != null && typeof value != "string"
          ? value && value.size <= FILE_SIZE
          : true
      )
      .test("fileFormat", "פורמט לא נתמך", (value: File) =>
        value != null && typeof value != "string"
          ? SUPPORTED_FORMATS.includes(value.type)
          : true
      ),
    quotationNotes: Yup.string().optional(),
  });

  const handelOnSubmit = (project: any) => {
    if (data) project = { ...project, projectId: data.id };
    if (
      data &&
      project.quotation === data.quotation &&
      project.file === data.agreement &&
      project.quotationNotes === data.quotationNotes
    )
      return;
    data && data.quotation != null
      ? dispatch(updateProjectQuotation(project))
          .unwrap()
          .then(() => {
            dispatch(getProjectById({ projectId: Number(project.projectId) }));
            dispatch(
              msg({ msg: "ערכית סכום / הסכם בוצע בהצלחה", type: "success" })
            );
            handelClose();
          })
          .catch((error: any) => dispatch(msg({ msg: error, type: "error" })))
      : dispatch(addProjectQuotation(project))
          .unwrap()
          .then(() => {
            dispatch(getProjectById({ projectId: Number(project.projectId) }));
            dispatch(msg({ msg: "הוספת סכום / הסכם בהצלחה", type: "success" }));
            handelClose();
          })
          .catch((error: any) => dispatch(msg({ msg: error, type: "error" })));
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
            validateOnChange={false}
            enableReinitialize
          >
            {(formik: FormikProps<any>) => {
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
                          type="number"
                          label="סכום"
                          name="quotation"
                          fullWidth={true}
                        />
                        <Grid container>
                          <Grid item sm={6}>
                            <Stack
                              direction="column"
                              justifyContent="space-between"
                              alignItems="flex-start"
                              spacing={1}
                              width="100%"
                            >
                              <Typography variant="caption">
                                העלאת הסכם <br />
                              </Typography>
                              <Typography
                                variant="caption"
                                gutterBottom
                                color={theme.palette.error.light}
                              >
                                ** הפורמטים הנתמכים הם jpg | jpeg | png | gif
                              </Typography>
                            </Stack>
                          </Grid>
                          <Grid item sm={6}>
                            <FormikControl
                              control="inputFile"
                              type="file"
                              label="הסכם"
                              name="file"
                              fullWidth={true}
                            />
                          </Grid>
                        </Grid>

                        <FormikControl
                          control="input"
                          type="text"
                          label="הערות"
                          name="quotationNotes"
                          fullWidth={true}
                        />
                      </Stack>
                    </Grid>

                    <DialogActions style={{ display: "flex" }}>
                      <Button
                        sx={{ mt: 1.5 }}
                        fullWidth
                        variant="outlined"
                        type="submit"
                        disabled={!formik.isValid}
                      >
                        שמור
                      </Button>
                      <Button
                        sx={{ mt: 1.5 }}
                        variant="outlined"
                        color="error"
                        onClick={handelClose}
                      >
                        ביטול
                      </Button>
                    </DialogActions>
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

export default QuotationAction;
