import React from "react";
import * as Yup from "yup";

import {
  Autocomplete,
  Box,
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  FormControl,
  FormHelperText,
  Grid,
  InputLabel,
  OutlinedInput,
  Stack,
  TextField,
} from "@mui/material";
import dayjs from "dayjs";
import {
  Field,
  FieldArray,
  FieldProps,
  Form,
  Formik,
  FormikProps,
  getIn,
} from "formik";
import { useAppSelector } from "../../store/hooks";
import { IRecord } from "../../_interfaces/record.interface";
import FormikControl from "../customizeComponents/FormikForm/FormikControler/FormikControl";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import "dayjs/locale/he"; // import locale
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { DesktopDatePicker } from "@mui/x-date-pickers";
import IconButton from "@mui/material/IconButton";
import DeleteIcon from "@mui/icons-material/Delete";
import AddIcon from "@mui/icons-material/Add";

dayjs.locale("he");

interface Props {
  open: boolean;
  handelClose: () => void;
  data?: IRecord;
  handelAddNewRecords?: (newDatew: IRecord) => void;
  handelEditRecords: (newDatew: IRecord) => void;
}
const ReportsAction = ({
  data,
  open,
  handelClose,
  handelAddNewRecords,
  handelEditRecords,
}: Props) => {
  const { activeEmployees, employees } = useAppSelector(
    (state) => state.employee
  );
  const { projects } = useAppSelector((state) => state.projects);
  const initialValues: IRecord =
    data != undefined
      ? {
          id: data.id,
          date: dayjs(data.date).format(),
          employeeId: data.employeeId,
          projectId: data.projectId,
          startAt: dayjs(data.startAt)
            .set("hour", 7)
            .set("minute", 0)
            .set("second", 0)
            .toDate(),
          endAt: dayjs(data.endAt)
            .set("hour", 16)
            .set("minute", 0)
            .set("second", 0)
            .toDate(),
          notes: data.notes,
        }
      : {
          date: dayjs(localStorage.getItem("pmr_savedDate")).format(
            "YYYY-MM-DD HH:mm:ss"
          ),
          employeeId: "",
          projectId: [{ projectId: "", notes: "" }],
          startAt: dayjs()
            .set("hour", 7)
            .set("minute", 0)
            .set("second", 0)
            .toDate(),
          endAt: dayjs()
            .set("hour", 16)
            .set("minute", 0)
            .set("second", 0)
            .toDate(),
          notes: "",
        };

  const validationSchema = Yup.object({
    date: Yup.string().required("תאריך חובה"),
    employeeId: Yup.array(Yup.number().required()).required("בחירת עובד חובה"),
    projectId: Yup.array().of(
      Yup.object().shape({
        projectId: Yup.number().required("בחירת מיקום עבודה חובה"),
        notes: Yup.string(),
      })
    ),
  });

  // const validationSchema ;
  const handelOnSubmit = (values: IRecord) => {
    const newData = {
      ...values,
      date: new Date(values.date)
        .toLocaleDateString("en-CA", { timeZone: "Asia/Jerusalem" })
        .replace(/\D/g, "-"),
    };
    console.log(newData);
    data
      ? handelEditRecords(newData)
      : handelAddNewRecords != undefined && handelAddNewRecords(newData);
  };

  return (
    <Dialog
      open={open}
      aria-labelledby="alert-dialog-title"
      aria-describedby="alert-dialog-description"
    >
      {
        <DialogTitle>
          {data ? `עריכת דיווח  ${data.date}` : "הוספת דיווח חדש"}
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
            enableReinitialize={data ? true : false}
          >
            {({ values, isValid }: FormikProps<IRecord>) => {
              return (
                <Form>
                  <Grid container>
                    <Grid item xs={12}>
                      <Stack
                        direction={{ xs: "column" }}
                        justifyContent="space-between"
                        spacing={1}
                      >
                        <LocalizationProvider dateAdapter={AdapterDayjs}>
                          <Field name="date">
                            {({ field, form, ...extraProps }: FieldProps) => {
                              const { setFieldValue } = form;
                              const { value } = field;
                              const error = getIn(form.errors, "date");
                              const touch = getIn(form.touched, "date");
                              return (
                                <LocalizationProvider
                                  dateAdapter={AdapterDayjs}
                                >
                                  <FormControl
                                    sx={{ mt: 1 }}
                                    variant="outlined"
                                    fullWidth
                                    error={error && touch ? true : false}
                                  >
                                    <InputLabel htmlFor="date"></InputLabel>
                                    <DesktopDatePicker
                                      label="תאריך דיווח"
                                      value={value}
                                      onChange={(val) => {
                                        localStorage.setItem(
                                          "pmr_savedDate",
                                          dayjs(val).format(
                                            "YYYY-MM-DD HH:mm:ss"
                                          )
                                        );
                                        setFieldValue(
                                          "date",
                                          new Date(val)
                                            .toLocaleDateString("en-CA", {
                                              timeZone: "Asia/Jerusalem",
                                            })
                                            .replace(/\D/g, "-")
                                        );

                                        values.startAt = new Date(
                                          dayjs(val).year(),
                                          dayjs(val).month(),
                                          dayjs(val).get("date"),
                                          7,
                                          0,
                                          0
                                        );
                                        values.endAt = new Date(
                                          dayjs(val).year(),
                                          dayjs(val).month(),
                                          dayjs(val).get("date"),
                                          16,
                                          0,
                                          0
                                        );
                                      }}
                                      {...extraProps}
                                      renderInput={(params) => {
                                        return (
                                          <TextField
                                            {...params}
                                            helperText={null}
                                          />
                                        );
                                      }}
                                      {...extraProps}
                                    />
                                    <FormHelperText id="date" error>
                                      {typeof error === "string" && touch
                                        ? error.toString()
                                        : null}
                                    </FormHelperText>
                                  </FormControl>
                                </LocalizationProvider>
                              );
                            }}
                          </Field>
                        </LocalizationProvider>

                        <FormikControl
                          control="autoComplete"
                          type="text"
                          label="שם עובד"
                          name="employeeId"
                          options={data ? employees : activeEmployees}
                          fullWidth={true}
                          readOnly={data && true}
                          selected={data && data.employeeId}
                        />
                      </Stack>
                    </Grid>
                    <Grid item xs={12}>
                      <Stack
                        direction={{ xs: "column" }}
                        justifyContent="space-between"
                      >
                        <FieldArray name="projectId">
                          {(fieldArrayProps: any) => {
                            const { push, remove, form } = fieldArrayProps;
                            const { values, errors, touched, setFieldValue } =
                              form;

                            const { projectId } = values;
                            return (
                              <>
                                {projectId.map((pn: any, index: number) => {
                                  const error = getIn(
                                    form.errors,
                                    `projectId.${index}.projectId`
                                  );
                                  const touch = getIn(
                                    form.touched,
                                    `projectId.${index}.projectId`
                                  );
                                  return (
                                    <Stack
                                      direction="column"
                                      key={index}
                                      spacing={1}
                                      sx={{ mt: 1, mb: 1 }}
                                    >
                                      <Stack
                                        direction={{ sx: "column", sm: "row" }}
                                        spacing={1}
                                      >
                                        <FormControl
                                          variant="outlined"
                                          error={
                                            errors && touched ? true : false
                                          }
                                          sx={{ width: { sm: 255 } }}
                                        >
                                          <Autocomplete
                                            defaultValue={
                                              data &&
                                              projects.find(
                                                (p: any) =>
                                                  p.id === pn.projectId
                                              )
                                            }
                                            isOptionEqualToValue={(
                                              option,
                                              value
                                            ) => option.id === value.id}
                                            disablePortal
                                            disableClearable
                                            onChange={(
                                              event: any,
                                              newValue: any | null
                                            ) => {
                                              setFieldValue(
                                                `projectId.${index}.projectId`,
                                                newValue.id
                                              );
                                            }}
                                            id="tags-outlined"
                                            options={projects}
                                            getOptionLabel={(option) =>
                                              option.projectName
                                            }
                                            renderInput={(params) => (
                                              <TextField
                                                name={`projectId.${index}.projectId`}
                                                {...params}
                                                label="מיקום"
                                                value={pn.projectId}
                                              />
                                            )}
                                          />

                                          <FormHelperText
                                            id={`projectId.${index}.projectId`}
                                            error
                                          >
                                            {typeof error === "string" && touch
                                              ? error.toString()
                                              : null}
                                          </FormHelperText>
                                        </FormControl>

                                        <FormControl variant="outlined">
                                          <InputLabel
                                            htmlFor={`projectId[${index}].notes`}
                                          >
                                            הערות
                                          </InputLabel>

                                          <OutlinedInput
                                            defaultValue={data && pn.notes}
                                            margin="dense"
                                            id={`projectId[${index}].notes`}
                                            onChange={(
                                              event: React.ChangeEvent<
                                                | HTMLTextAreaElement
                                                | HTMLInputElement
                                              >
                                            ) => {
                                              setFieldValue(
                                                `projectId.${index}.notes`,
                                                event.target.value
                                              );
                                            }}
                                          />
                                        </FormControl>

                                        <Stack justifyContent="center">
                                          <>
                                            {index > 0 && (
                                              <IconButton
                                                onClick={() => remove(index)}
                                                aria-label="delete"
                                                size="small"
                                                color="error"
                                              >
                                                <DeleteIcon fontSize="inherit" />
                                              </IconButton>
                                            )}

                                            <IconButton
                                              onClick={() =>
                                                push({
                                                  projectId: "",
                                                  notes: "",
                                                })
                                              }
                                              aria-label="add"
                                              size="small"
                                              color="primary"
                                            >
                                              <AddIcon fontSize="inherit" />
                                            </IconButton>
                                          </>
                                        </Stack>
                                      </Stack>
                                    </Stack>
                                  );
                                })}
                              </>
                            );
                          }}
                        </FieldArray>
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
                          control="timePicker"
                          type="date"
                          label="שעת התחלה"
                          name="startAt"
                        />
                        <FormikControl
                          control="timePicker"
                          type="date"
                          label="שעת סיום"
                          name="endAt"
                        />
                      </Stack>
                      <Stack spacing={1}>
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
                      <Stack>
                        <DialogActions style={{ display: "flex" }}>
                          <Button
                            variant="outlined"
                            type="submit"
                            disabled={!isValid}
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
                      </Stack>
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

export default ReportsAction;
