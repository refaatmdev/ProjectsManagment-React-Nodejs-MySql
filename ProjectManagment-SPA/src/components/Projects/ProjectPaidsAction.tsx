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
  addProjectPaids,
  getProjectPaids,
  updateProjectPaids,
} from "../../store/projectsSlice";
import { msg } from "../../store/snackBardSlice";
import { useAppDispatch } from "../../store/hooks";
import dayjs from "dayjs";
import { IPaids } from "../../_interfaces/paids.interface";
import { useTheme } from "@mui/material/styles";

export interface ProjectPaidAction {
  data?: IPaids;
  projectId: any;
  show: boolean;
  handelClose: () => void;
}

const ProjectPaidsAction = ({
  data,
  show,
  projectId,
  handelClose,
}: ProjectPaidAction) => {
  const dispatch = useAppDispatch();

  const theme = useTheme();

  const FILE_SIZE = 5000 * 1024;
  const SUPPORTED_FORMATS = [
    "image/jpg",
    "image/jpeg",
    "image/gif",
    "image/png",
  ];

  const methodOptions: Array<any> = [
    { value: "cash", label: "מזומן" },
    { value: "check", label: "ציק" },
  ];
  console.log(data);
  const initialValues: IPaids =
    data != undefined
      ? {
          id: data.id,
          paidDate: dayjs(data.paidDate).format("YYYY-MM-DD"),
          paid: data.paid,
          projectId: projectId,
          checkImg: data.checkImg,
          method: data.method,
          notes: data.notes,
        }
      : {
          paidDate: dayjs().format("YYYY-MM-DD"),
          paid: 0,
          checkImg: "",
          projectId: projectId,
          method: "",
          notes: "",
        };

  const validationSchema = Yup.object({
    id: Yup.number().optional(),
    paidDate: Yup.string().required(),
    paid: Yup.number().required("סכום ששולם חובה"),
    checkImg: Yup.mixed()
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
    method: Yup.string().required("שיטת תשלום חובה"),
    notes: Yup.string().optional(),
  });

  const handelOnSubmit = (paids: IPaids) => {
    if (!paids) return;

    if (data == undefined) {
      dispatch(addProjectPaids(paids))
        .unwrap()
        .then(() => {
          dispatch(getProjectPaids({ projectId: Number(projectId) }));
          dispatch(msg({ msg: "הוספת תשלום בהצלחה", type: "success" }));
          handelClose();
        })
        .catch((error: any) => dispatch(msg({ msg: error, type: "error" })));
    } else {
      console.log("update");
      console.log(paids);

      dispatch(updateProjectPaids(paids))
        .unwrap()
        .then(() => {
          dispatch(
            msg({
              msg: `תשלום ${paids.paidDate} עודכן בהצלחה`,
              type: "success",
            })
          );
          dispatch(getProjectPaids({ projectId: Number(projectId) }));

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
          {data
            ? `עריכת תשלום ${dayjs(data.paidDate).format("YYYY-MM-DD")}`
            : "הוספת תשלום חדש"}
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
            {(formik: FormikProps<IPaids>) => {
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
                          control="datePicker"
                          type=" date"
                          label="תאריך תשלום"
                          name="paidDate"
                          fullWidth={true}
                        />
                        <FormikControl
                          control="input"
                          type="number"
                          label="סכום "
                          name="paid"
                          fullWidth={true}
                        />
                        <FormikControl
                          control="select"
                          label="שיטת תשלום"
                          name="method"
                          fullWidth={true}
                          options={methodOptions}
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
                              name="checkImg"
                              fullWidth={true}
                            />
                          </Grid>
                        </Grid>
                        <FormikControl
                          control="input"
                          type="text"
                          label="הערות"
                          name="notes"
                          fullWidth={true}
                        />
                      </Stack>
                    </Grid>

                    <Grid item xs={12}>
                      <Stack></Stack>

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

export default ProjectPaidsAction;
