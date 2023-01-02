import React from "react";
import { Formik, Form, FormikProps } from "formik";
import * as Yup from "yup";
import { Box } from "@mui/system";
import FormikControl from "../customizeComponents/FormikForm/FormikControler/FormikControl";
import { Button, Grid, Stack } from "@mui/material";
import { useAppSelector, useAppDispatch } from "../../store/hooks";
import { addEmployeeProps } from "./AddEmployee";
import { updateDailyWage } from "../../store/employeesSlice";

import dayjs from "dayjs";
import { msg } from "../../store/snackBardSlice";
import { IMafrea } from "../../_interfaces/mafrea.interfac";
import {
  addMafrea,
  getMafreaot,
  updateMafrea,
  updateRecord,
} from "../../store/recordsSlice";

interface addRiotProps extends addEmployeeProps {
  data?: IMafrea;
}

const AddARiot = ({ closeModal, data }: addRiotProps) => {
  console.log(data);
  const dispatch = useAppDispatch();

  const initialValues: IMafrea =
    data != undefined
      ? {
          id: data.id,
          employeeId: data.employeeId,
          amount: data.amount,
          createdAt: data.createdAt,
          notes: data.notes,
        }
      : {
          employeeId: "",
          amount: 0,
          createdAt: "",
          notes: "",
        };

  const { activeEmployees, employees } = useAppSelector(
    (state) => state.employee
  );

  const validationSchema = Yup.object({
    employeeId: Yup.string().required("בחירת עובד חובה"),
    amount: Yup.number()
      .required("סכום מפרעה חובה")
      .typeError("סכום צריך להיות מספר"),
    createdAt: Yup.date()
      .required(" בתאריך חובה")
      .default(function () {
        return new Date();
      }),
  });

  const onSubmit = (values: IMafrea) => {
    const { id, employeeId, amount, createdAt, notes } = values;
    const mafreaData: IMafrea = {
      id: id,
      employeeId: employeeId,
      amount: amount,
      createdAt: dayjs(createdAt).format("YYYY-MM-DD"),
      notes: notes,
    };
    data
      ? dispatch(updateMafrea(mafreaData))
          .unwrap()
          .then(() => {
            dispatch(getMafreaot({}));
            dispatch(msg({ msg: "עדכון דיווח בהצלחה", type: "success" }));
            closeModal();
          })
          .catch((error: any) => dispatch(msg({ msg: error, type: "error" })))
      : dispatch(addMafrea(mafreaData))
          .unwrap()
          .then(() => {
            dispatch(getMafreaot({}));
            dispatch(msg({ msg: "הוספת מפרעה בוצעה בהצלחה", type: "success" }));
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
        enableReinitialize={data ? true : false}
        validateOnChange={false}
      >
        {(formik: FormikProps<IMafrea>) => {
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
                      options={data ? employees : activeEmployees}
                      readOnly={data && true}
                      selected={data && data.employeeId}
                    />
                  </Stack>
                </Grid>
                <Grid item xs={12}>
                  <Stack>
                    <FormikControl
                      control="input"
                      type="number"
                      label="סכום מפרעה"
                      name="amount"
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
                      name="createdAt"
                      fullWidth={true}
                      //   datePickerViews={["year", "month"]}
                    />
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

export default AddARiot;
