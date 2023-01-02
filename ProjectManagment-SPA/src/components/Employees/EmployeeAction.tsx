import {
  Box,
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
  Modal,
} from "@mui/material";
import React from "react";
import { useAppSelector } from "../../store/hooks";
import { IEmployee } from "../../_interfaces/emplyee.interface";
import { IMafrea } from "../../_interfaces/mafrea.interfac";
import AddARiot from "./AddARiot";
import AddDailyWageEmployee from "./AddDailyWageEmployee";
import AddEmployee from "./AddEmployee";
import EditEmployee from "./EditEmployee";

interface EmoloyeeModalsProps {
  type: string;
  show: boolean;
  handleClose: () => void;
  headTitle?: string;
  employee?: IEmployee;
  mafreaData?: IMafrea;
}

export default function EmployeeAction({
  type,
  show,
  handleClose,
  headTitle,
  employee,
  mafreaData,
}: EmoloyeeModalsProps) {
  const renderCurrentSelection = () => {
    switch (type) {
      case "dailyWage":
        return <AddDailyWageEmployee closeModal={handleClose} />;
        break;
      case "addEmployee":
        return <AddEmployee closeModal={handleClose} />;
        break;

      case "editEmployee":
        if (employee)
          return <EditEmployee data={employee} closeModal={handleClose} />;
        break;
      case "addARiot":
        return <AddARiot closeModal={handleClose} />;
        break;
      case "editRiot":
        if (mafreaData)
          return <AddARiot data={mafreaData} closeModal={handleClose} />;
        break;

      default:
        break;
    }
  };

  return (
    <>
      <Dialog
        open={show}
        onClose={handleClose}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        {headTitle && <DialogTitle>{headTitle}</DialogTitle>}
        <DialogContent>{renderCurrentSelection()}</DialogContent>
        <DialogActions style={{ display: "flex" }}>
          <Button variant="outlined" color="error" onClick={handleClose}>
            ביטול
          </Button>
        </DialogActions>
      </Dialog>
    </>
  );
}
