import React from "react";
import { Field, FieldProps, getIn } from "formik";
import {
  FormControl,
  FormHelperText,
  InputLabel,
  MenuItem,
  Select,
} from "@mui/material";
import { IEmployee } from "../../../../../_interfaces/emplyee.interface";
import { IProject } from "../../../../../_interfaces/project.interface";

interface FormControlProps {
  label: string;
  name: string;
  fullWidth?: boolean;
  options?: IEmployee[] | IProject[] | any[];
}

const SelectF = ({ label, name, options, fullWidth }: FormControlProps) => {
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
            <InputLabel htmlFor={name}>{label}</InputLabel>
            <Select
              labelId={label}
              id={name}
              label="Age"
              {...field}
              {...extraProps}
            >
              <MenuItem value="">
                <em>None</em>
              </MenuItem>
              {options &&
                name == "employeeId" &&
                options.map((o: any) => {
                  return (
                    <MenuItem key={o.id} value={o.id}>
                      {o.firstName} {o.lastName}
                    </MenuItem>
                  );
                })}
              {options &&
                name == "projectId" &&
                options.map((o: any) => {
                  return (
                    <MenuItem key={o.id} value={o.id}>
                      {o.projectName}
                    </MenuItem>
                  );
                })}
            </Select>
            <FormHelperText id={name} error>
              {typeof error === "string" && touch ? error.toString() : null}
            </FormHelperText>
          </FormControl>
        );
      }}
    </Field>
  );
};

export default SelectF;
