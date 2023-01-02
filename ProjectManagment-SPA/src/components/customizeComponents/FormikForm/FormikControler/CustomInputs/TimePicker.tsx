import {
  FormControl,
  FormHelperText,
  InputLabel,
  TextField,
} from "@mui/material";
import { DesktopTimePicker, LocalizationProvider } from "@mui/x-date-pickers";
import { Field, FieldProps, getIn } from "formik";
import React from "react";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";

import "react-datepicker/dist/react-datepicker.css";

interface FormControlProps {
  label: string;
  name: string;
  // fullWidth?: boolean;
  // datePickerViews?: any[];
}
const TimePicker = ({ label, name }: FormControlProps) => {
  return (
    <LocalizationProvider dateAdapter={AdapterDayjs}>
      <Field name={name}>
        {({ field, form, ...extraProps }: FieldProps) => {
          const { setFieldValue } = form;
          const { value } = field;
          const error = getIn(form.errors, name);
          const touch = getIn(form.touched, name);
          return (
            <LocalizationProvider dateAdapter={AdapterDayjs}>
              <FormControl
                sx={{ mt: 1 }}
                variant="outlined"
                // fullWidth={fullWidth}
                error={error && touch ? true : false}
              >
                <InputLabel htmlFor={name}></InputLabel>
                <DesktopTimePicker
                  showToolbar={true}
                  ampm={true}
                  ampmInClock={true}
                  minutesStep={10}
                  label={label}
                  value={value}
                  {...extraProps}
                  onChange={(val) => setFieldValue(name, val.format())}
                  renderInput={(params) => <TextField {...params} />}
                />
                <FormHelperText id={name} error>
                  {typeof error === "string" && touch ? error.toString() : null}
                </FormHelperText>
              </FormControl>
            </LocalizationProvider>
          );
        }}
      </Field>
    </LocalizationProvider>
  );
};

export default TimePicker;
