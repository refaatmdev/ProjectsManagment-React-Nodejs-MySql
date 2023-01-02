import React from "react";
import { Formik, Form, FormikProps } from "formik";
import * as Yup from "yup";
import { Box } from "@mui/system";
import FormikControl from "../customizeComponents/FormikForm/FormikControler/FormikControl";
import { Button, Grid, Stack } from "@mui/material";
import { IDWage } from "../../_interfaces/dailyWage.interface";
import { useAppSelector, useAppDispatch } from "../../store/hooks";
import { addEmployeeProps } from "./AddEmployee";
import { updateDailyWage } from "../../store/employeesSlice";

import dayjs from "dayjs";
import { msg } from "../../store/snackBardSlice";

const AddDailyWageEmployee = ({ closeModal }: addEmployeeProps) => {
  const dispatch = useAppDispatch();

  const initialValues: IDWage = {
    employeeId: "",
    dailyWage: 0,
    startFrom: "",
  };

  const { activeEmployees } = useAppSelector((state) => state.employee);

  const validationSchema = Yup.object({
    employeeId: Yup.string().required("בחירת עובד חובה"),
    dailyWage: Yup.number()
      .required("שכר יומי חובה")
      .typeError("שכר צריך להיות מספר"),
    startFrom: Yup.date()
      .required("החל מתאריך חובה")
      .default(function () {
        return new Date();
      }),
  });

  const onSubmit = (values: IDWage) => {
    const { employeeId, dailyWage, startFrom } = values;
    const dailyWageData: IDWage = {
      employeeId: employeeId,
      dailyWage: dailyWage,
      startFrom: dayjs(startFrom)
        .startOf("month")
        .format("YYYY-MM-DD HH:mm:ss"),
    };
    dispatch(updateDailyWage(dailyWageData))
      .unwrap()
      .then(() => {
        dispatch(msg({ msg: "עדכון שכר יומי בוצע בהצלחה", type: "success" }));
        closeModal();
      })
      .catch((error) => dispatch(msg({ msg: error, type: "error" })));
  };
  return (
    <Box
      maxWidth={"350px"}
      sx={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
      }}
    >
      <Formik
        initialValues={initialValues}
        validationSchema={validationSchema}
        onSubmit={onSubmit}
      >
        {(formik: FormikProps<IDWage>) => {
          return (
            <Form>
              <Grid container>
                <Grid item xs={12}>
                  <Stack
                    spacing={1}
                    direction={{ xs: "column", sm: "row" }}
                    // justifyContent="space-between"
                    alignItems="flex-end"
                  >
                    <FormikControl
                      control="select"
                      label="עובד"
                      name="employeeId"
                      fullWidth={true}
                      options={activeEmployees}
                    />
                  </Stack>
                </Grid>
                <Grid item xs={12}>
                  <Stack>
                    <FormikControl
                      control="input"
                      type="number"
                      label="שכר יומי"
                      name="dailyWage"
                      fullWidth={true}
                    />
                  </Stack>
                </Grid>
                <Grid item xs={12}>
                  <Stack>
                    <FormikControl
                      control="datePicker"
                      type="date"
                      label="החל מתאריך"
                      name="startFrom"
                      fullWidth={true}
                      datePickerViews={["year", "month"]}
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
                      שלח
                    </Button>
                  </Stack>
                </Grid>
              </Grid>
            </Form>
          );
        }}
      </Formik>
    </Box>
  );
};

export default AddDailyWageEmployee;
