import React from "react";
import { Field, FieldProps, getIn } from "formik";
import {
  FormControl,
  FormHelperText,
  InputLabel,
  TextField,
} from "@mui/material";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import dayjs from "dayjs";
// import { DesktopDatePicker } from "@mui/x-date-pickers/DatePicker";
import "dayjs/locale/he"; // import locale
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { DesktopDatePicker } from "@mui/x-date-pickers";
dayjs.locale("he");
interface FormControlProps {
  label: string;
  name: string;
  fullWidth?: boolean;
  datePickerViews?: any[];
}
const DatePickerF = ({
  label,
  name,
  datePickerViews = ["year", "month", "day"],
  fullWidth,
}: FormControlProps) => {
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
                fullWidth={fullWidth}
                error={error && touch ? true : false}
              >
                <InputLabel htmlFor={name}></InputLabel>
                <DesktopDatePicker
                  views={datePickerViews}
                  label={label}
                  value={value}
                  onChange={(val) => setFieldValue(name, val.format())}
                  inputFormat={
                    datePickerViews[2] === "day" ? "DD-MM-YYYY" : "MM-YYYY"
                  }
                  {...extraProps}
                  renderInput={(params) => {
                    return <TextField {...params} helperText={null} />;
                  }}
                  {...extraProps}
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

export default DatePickerF;
