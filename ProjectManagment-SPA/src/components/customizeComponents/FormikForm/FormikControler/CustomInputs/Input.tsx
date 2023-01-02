import React from "react";
import { Field, FieldProps, getIn } from "formik";
import {
  FormControl,
  FormHelperText,
  InputLabel,
  OutlinedInput,
  FormControlProps,
} from "@mui/material";

interface FormControlsProps {
  label: string;
  name: string;
  fullWidth?: boolean;
  sxContent?: FormControlProps["sx"];
  readOnly?: boolean;
}

const InputF = ({
  label,
  name,
  fullWidth,
  sxContent,
  readOnly,
}: FormControlsProps) => {
  return (
    <Field name={name}>
      {({ field, form, ...extraProps }: FieldProps) => {
        const error = getIn(form.errors, name);
        const touch = getIn(form.touched, name);
        return (
          <FormControl
            sx={{ ...sxContent, mt: 1, mr: "0px" }}
            // style={{mt: "10px"}}

            variant="outlined"
            fullWidth={fullWidth}
            error={error && touch ? true : false}
          >
            <InputLabel htmlFor={name}>{label}</InputLabel>
            <OutlinedInput
              readOnly={readOnly && readOnly}
              margin="dense"
              id={name}
              {...field}
              {...extraProps}
            />
            <FormHelperText id={name} error>
              {typeof error === "string" && touch ? error.toString() : null}
            </FormHelperText>
          </FormControl>
        );
      }}
    </Field>
  );
};

export default InputF;
