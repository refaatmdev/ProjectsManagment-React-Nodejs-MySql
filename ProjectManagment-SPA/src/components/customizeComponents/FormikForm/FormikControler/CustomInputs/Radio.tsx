import React from "react";
import { Field, FieldProps, getIn } from "formik";
import {
  FormControl,
  FormHelperText,
  FormLabel,
  FormControlLabel,
  RadioGroup,
  Radio,
} from "@mui/material";

interface FormControlProps {
  label: string;
  name: string;
  fullWidth?: boolean;
  options?: any;
}
const RadioC = ({ label, name, options, fullWidth }: FormControlProps) => {
  return (
    <Field name={name}>
      {({ field, form, ...extraProps }: FieldProps) => {
        const error = getIn(form.errors, name);
        const touch = getIn(form.touched, name);
        return (
          <FormControl
            sx={{ mt: 1 }}
            variant="outlined"
            fullWidth={fullWidth}
            error={error && touch ? true : false}
          >
            <FormLabel htmlFor={name}>{label}</FormLabel>
            <RadioGroup id={name} {...field} {...extraProps}>
              {options &&
                options.map((o: any) => {
                  return (
                    <FormControlLabel
                      key={o.key}
                      value={o.value}
                      control={<Radio />}
                      label={o.key}
                    />
                  );
                })}
            </RadioGroup>
            <FormHelperText id={name} error>
              {typeof error === "string" && touch ? error.toString() : null}
            </FormHelperText>
          </FormControl>
        );
      }}
    </Field>
  );
};
export default RadioC;
