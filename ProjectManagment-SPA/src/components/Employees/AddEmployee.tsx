import React from "react";
import { Formik, Form, FormikProps } from "formik";
import * as Yup from "yup";
import { IEmployee } from "../../_interfaces/emplyee.interface";
import { useAppDispatch } from "../../store/hooks";
import { addEmployeeA } from "../../store/employeesSlice";
import { Box, Button, Grid, Stack } from "@mui/material";
import FormikControl from "../customizeComponents/FormikForm/FormikControler/FormikControl";
export interface addEmployeeProps {
  closeModal: () => void;
}
const AddEmployee = ({ closeModal }: addEmployeeProps) => {
  const dispatch = useAppDispatch();

  const initialValues: IEmployee = {
    firstName: "",
    lastName: "",
    phone: "",
    bankAccount: 0,
    bankBranch: "",
    createdAt: "",
  };

  const validationSchema = Yup.object({
    firstName: Yup.string().required("שם פרטי חובה"),
    lastName: Yup.string().required("שם משפחה חובה"),
    phone: Yup.string().required("מספר פלאפון חובה"),
    bankAccount: Yup.number().required("מספר חשבון בנק חובה"),
    bankBranch: Yup.number().required("סניף בנק חובה"),
    createdAt: Yup.string().required("תאריך התחלה חובה"),
  });

  const onSubmit = (values: IEmployee) => {
    dispatch(addEmployeeA(values)).then(() => closeModal());
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
        {(formik: FormikProps<IEmployee>) => {
          return (
            <Form>
              <Grid container>
                <Grid item xs={12}>
                  <Stack
                    spacing={1}
                    direction={{ xs: "column", sm: "row" }}
                    alignItems="flex-end"
                  >
                    <FormikControl
                      control="input"
                      type="text"
                      label="שם פרטי"
                      name="firstName"
                      fullWidth={true}
                    />
                    <FormikControl
                      control="input"
                      type="text"
                      label="שם משפחה"
                      name="lastName"
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
                      name="phone"
                      fullWidth={true}
                    />
                  </Stack>
                </Grid>
                <Grid item xs={12}>
                  <Stack
                    direction={{ xs: "column", sm: "row" }}
                    justifyContent="space-between"
                    alignItems="center"
                    spacing={1}
                  >
                    <FormikControl
                      control="input"
                      type="text"
                      label="מספר חשבון בנק"
                      name="bankAccount"
                      fullWidth={true}
                    />
                    <FormikControl
                      control="input"
                      type="text"
                      label="מספר סניף"
                      name="bankBranch"
                      fullWidth={true}
                    />
                  </Stack>
                </Grid>
                <Grid item xs={12}>
                  <Stack>
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

export default AddEmployee;
