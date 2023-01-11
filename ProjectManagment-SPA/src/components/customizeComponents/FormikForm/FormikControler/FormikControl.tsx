import React from "react";
// import Textarea from './Textarea'
// import Select from './Select'
// import RadioButtons from './RadioButtons'
// import CheckboxGroup from './CheckboxGroup'
// import DatePicker from './DatePicker'
// import ChakraInput from './ChakraInput'
import { FieldProps } from "formik";
import InputF from "./CustomInputs/Input";
import { IEmployee } from "../../../../_interfaces/emplyee.interface";
import SelectF from "./CustomInputs/Select";
import DatePicker from "./CustomInputs/DatePicker";
import { FormControlProps } from "@mui/material";
import RadioC from "./CustomInputs/Radio";
import TimePicker from "./CustomInputs/TimePicker";
import AutoComplete from "./CustomInputs/AutoComplete";
import { IProject } from "../../../../_interfaces/project.interface";
import InputFile from "./CustomInputs/InputFile";

interface FormikProps {
  control: string;
  label: string;
  name: string;
  type?: string;
  fullWidth?: boolean;
  employeeOptions?: IEmployee[];
  datePickerViews?: any[];
  sxContent?: FormControlProps["sx"];
  options?: IEmployee[] | IProject[] | any[];
  readOnly?: boolean;
  selected?: string;
}
function FormikControl({
  control,
  employeeOptions,
  options,
  ...rest
}: FormikProps) {
  switch (control) {
    case "input":
      return <InputF {...rest} />;
    case "select":
      return <SelectF options={options} {...rest} />;
    case "datePicker":
      return <DatePicker {...rest} />;
    case "radio":
      return <RadioC options={options} {...rest} />;
    case "timePicker":
      return <TimePicker {...rest} />;
    case "autoComplete":
      return options ? <AutoComplete options={options} {...rest} /> : null;
    case "inputFile":
      return <InputFile {...rest} />;

    default:
      return null;
  }
}

export default FormikControl;
