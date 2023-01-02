import { IEmployee } from "../_interfaces/emplyee.interface";
import jsPDF from "jspdf";
import dayjs from "dayjs";
import { IdataTable } from "../pages/Employees/Employee";
import { getTotalOfDuration, getTotalOfPayPerDay } from "./getTotals";
import getProjectsName from "./convertProjectIdToName";
import "jspdf-autotable";
import "./David-normal.js";
type props = {
  employeeData: IEmployee;
  currentMonth: string;
  monthDays: IdataTable[];
};

export default function downloadAsPDF({
  employeeData,
  currentMonth,
  monthDays,
}: props) {
  const tableRows: any = [];
  var dailyWage: number = 0;

  const pdf = new jsPDF();
  pdf.addFont("David-normal.ttf", "David", "normal");
  pdf.setFont("David"); // set font
  pdf.setFontSize(12);
  pdf.setTextColor(99);

  pdf.text(
    `דיווח שעות ל :  ${employeeData.firstName}  ${
      employeeData.lastName
    } - חודש - ${dayjs(currentMonth).format("YYYY-MM")}`
      .split("")
      .reverse()
      .join(""),
    110,
    10
  );
  const tableColumn = [
    [
      _fix("הערות"),
      _fix("תשלום ליום"),
      _fix("שכר יומי"),
      _fix("זמן"),
      _fix("סיים"),
      _fix("התחיל"),
      _fix("פרוייקט"),
      _fix("שם"),
      _fix("יום"),
      _fix("תאריך"),
    ],
  ];

  monthDays.forEach((report) => {
    const startAt = report.startAt ? dayjs(report.startAt).format("HH:mm") : "";
    const endAt = report.endAt ? dayjs(report.endAt).format("HH:mm") : "";
    const project = report.projectId && _fix(getProjectsName(report.projectId));
    if (dailyWage == 0) dailyWage = Number(report.dailyWage);
    const reportData = [
      report.notes.split("").reverse().join(""),
      report.payPerDay ? "₪ " + report.payPerDay : "",
      report.dailyWage ? "₪ " + report.dailyWage : "",
      Number(report.duration).toFixed(3) == "0.000"
        ? ""
        : Number(report.duration).toFixed(3),
      endAt,
      startAt,
      project,
      report.firstName.split("").reverse().join("") +
        " " +
        report.lastName.split("").reverse().join(""),
      dayjs(report.date)
        .locale("he")
        .format("dddd")
        .split("")
        .reverse()
        .join(""),
      dayjs(report.date).format("YYYY-MM-DD"),
    ];
    tableRows.push(reportData);
  });

  (pdf as any).autoTable({
    head: tableColumn,
    body: tableRows,
    theme: "grid",
    useCss: true,
    styles: {
      font: "David",
      align: "right",
      halign: "right",
      isSymmetricSwapping: true,
      isInputVisual: true,
      isOutputVisual: false,
    },
    didDrawCell: (data: any) => {},
  });

  const totalColumn = [
    [
      _fix("סך הכל"),
      _fix("שכר יומי"),
      _fix("ימי עבודה"),
      _fix("שעות עבודה"),
      _fix("תאריך"),
      _fix("שם"),
    ],
  ];

  const totalRows = [
    [
      "₪ " + getTotalOfPayPerDay(monthDays),
      "₪ " + dailyWage,
      Number(getTotalOfPayPerDay(monthDays)) / Number(dailyWage),
      Number(getTotalOfDuration(monthDays)).toFixed(3),
      _fix(
        `${dayjs(currentMonth).format("YYYY-MM").split("").reverse().join("")}`
      ),
      _fix(`${employeeData.firstName} ${employeeData.lastName}`),
    ],
  ];

  (pdf as any).autoTable({
    head: totalColumn,
    body: totalRows,
    theme: "grid",
    useCss: true,
    styles: {
      font: "David",
      align: "right",
      halign: "right",
      isSymmetricSwapping: true,
      isInputVisual: true,
      isOutputVisual: false,
    },
    didDrawCell: (data: any) => {},
  });
  const date = Date().split(" ");
  let text = "דוח שעות:".split("").reverse().join("");
  pdf.output("dataurlnewwindow");
  pdf.save(
    `report_${employeeData.firstName}-${employeeData.lastName}-${dayjs(
      currentMonth
    )
      .format("YYYY-MM")
      .split("")
      .reverse()
      .join("")}.pdf`
  );

  function _fix(str: string) {
    return str.split("").reverse().join("");
  }
}
