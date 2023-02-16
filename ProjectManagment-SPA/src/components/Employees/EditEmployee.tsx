import React from "react";
import { Formik, Form, FormikProps } from "formik";
import * as Yup from "yup";
import { Box } from "@mui/system";
import FormikControl from "../customizeComponents/FormikForm/FormikControler/FormikControl";
import { Button, Grid, Stack } from "@mui/material";
import { IEmployee } from "../../_interfaces/emplyee.interface";
import { useAppDispatch } from "../../store/hooks";
import { editEmployee } from "../../store/employeesSlice";
import { msg } from "../../store/snackBardSlice";

interface EditProps {
  data: IEmployee;
  closeModal: () => void;
}

const EditEmployee = ({ data, closeModal }: EditProps) => {
  const dispatch = useAppDispatch();

  const {
    id,
    firstName,
    lastName,
    phone,
    bankAccount,
    bankBranch,
    createdAt,
    isActive,
  } = data;
  const initialValues: IEmployee = {
    id: id,
    firstName: firstName,
    lastName: lastName,
    phone: phone,
    bankAccount: bankAccount,
    bankBranch: bankBranch,
    createdAt: createdAt,
    isActive: isActive,
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
    if (!values) return;
    dispatch(editEmployee(values))
      .unwrap()
      .then(() => {
        dispatch(msg({ msg: "עדכון עובד בהצלחה", type: "success" }));
        closeModal();
      })
      .catch((error) => dispatch(msg({ msg: error, type: "error" })));
  };
  const isActiveOptionss = [
    { key: "פעיל", value: "1" },
    { key: "לא פעיל", value: "0" },
  ];
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
        enableReinitialize
      >
        {(formik: FormikProps<IEmployee>) => {
          return (
            <Form>
              <Grid container>
                <Grid item xs={12}>
                  <Stack
                    spacing={1}
                    direction={{ xs: "column", sm: "row" }}
                    justifyContent="space-between"
                    alignItems="center"
                    pt={1}
                  >
                    <FormikControl
                      control="input"
                      type="text"
                      label="ID"
                      name="id"
                      sxContent={{ display: "none" }}
                    />
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
                    alignItems="flex-end"
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
                    <FormikControl
                      control="radio"
                      type="number"
                      label="סטטוס"
                      name="isActive"
                      fullWidth={true}
                      options={isActiveOptionss}
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
  );
};

export default EditEmployee;
