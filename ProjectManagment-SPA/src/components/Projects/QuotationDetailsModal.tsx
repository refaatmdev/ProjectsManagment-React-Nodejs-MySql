import React from "react";
import Modal from "@mui/material/Modal";
import { BASE_URL } from "../../config";
import { Box } from "@mui/material";
interface ModalProps {
  data: any;
  open: boolean;
  handleClose: () => void;
}

const style = {
  position: "absolute" as "absolute",
  top: "50%",
  left: "50%",
  transform: "translate(-50%, -50%)",
  width: "66%",
  height: "80%",
  bgcolor: "background.paper",
  border: "2px solid #000",
  boxShadow: 24,
  p: 4,
  overflowX: "hidden",
};
export const QuotationDetailsModal = ({
  data,
  open,
  handleClose,
}: ModalProps) => {
  return (
    <Modal
      open={open}
      onClose={handleClose}
      aria-labelledby="modal-modal-title"
      aria-describedby="modal-modal-description"
    >
      <Box sx={style}>
        {data.agreement != null ? (
          <img
            src={`${BASE_URL}/${data.agreement}`}
            alt={data.projectName}
            width="100%"
            height="80%"
            loading="lazy"
          />
        ) : (
          <></>
        )}
      </Box>
      {/* <Box sx={style}>
        <Typography id="modal-modal-title" variant="h6" component="h2">
          Text in a modal
        </Typography>
        <Typography id="modal-modal-description" sx={{ mt: 2 }}>
          Duis mollis, est non commodo luctus, nisi erat porttitor ligula.
        </Typography>
      </Box> */}
    </Modal>
  );
};
