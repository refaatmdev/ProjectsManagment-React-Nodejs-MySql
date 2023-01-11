import * as React from "react";
import Accordion from "@mui/material/Accordion";
import AccordionDetails from "@mui/material/AccordionDetails";
import AccordionSummary from "@mui/material/AccordionSummary";
import Typography from "@mui/material/Typography";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
import { IProjectNotes } from "../../_interfaces/project.interface";
import dayjs from "dayjs";
import { Chip, Divider, IconButton } from "@mui/material";
import DeleteIcon from "@mui/icons-material/Delete";
import EditIcon from "@mui/icons-material/Edit";
import { useTheme } from "@mui/material/styles";
import { Stack } from "@mui/system";

export interface IAccordionPanelProps {
  projectNotes: IProjectNotes[];
  handelUpdateNote: (data: IProjectNotes) => void;
  handelDeleteNote: (data: IProjectNotes) => void;
}
const ProjectNotes = ({
  projectNotes,
  handelUpdateNote,
  handelDeleteNote,
}: IAccordionPanelProps) => {
  const theme = useTheme();
  const [expanded, setExpanded] = React.useState<string | false>(false);

  const handleChange =
    (panel: string) => (event: React.SyntheticEvent, isExpanded: boolean) => {
      setExpanded(isExpanded ? panel : false);
    };
  return (
    <>
      {projectNotes.map((el, index) => {
        return (
          <Accordion
            expanded={expanded === `panel${index}`}
            onChange={handleChange(`panel${index}`)}
            key={`panel${index}`}
          >
            <AccordionSummary
              aria-controls="panel1d-content"
              id="panel1d-header"
            >
              <Typography variant="subtitle1">
                {dayjs(el.createdAt).format("YYYY-MM-DD")}
              </Typography>
            </AccordionSummary>
            <AccordionDetails>
              <Typography>{el.notes}</Typography>

              <Stack
                pt={2}
                direction="row"
                justifyContent={"flex-end"}
                divider={<Divider orientation="vertical" flexItem />}
                spacing={2}
              >
                <Chip
                  sx={{ "&:hover": { cursor: "pointer" } }}
                  label={"מחקה"}
                  color="error"
                  onClick={() => handelDeleteNote(el)}
                  icon={<DeleteIcon />}
                />
                <Chip
                  sx={{ "&:hover": { cursor: "pointer" } }}
                  label={"ערכיה"}
                  color="warning"
                  onClick={() => handelUpdateNote(el)}
                  icon={<EditIcon />}
                />
              </Stack>
            </AccordionDetails>
          </Accordion>
        );
      })}
    </>
  );
};

export default ProjectNotes;
