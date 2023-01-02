import dayjs from "dayjs";

export default function getDaysOfMonth(year: number, month: number) {
  var daysInMonth = dayjs(`${year}-${month}`).daysInMonth();
  var arrDays = [];

  while (daysInMonth) {
    arrDays.push({
      date: dayjs(`${year}-${month}-${daysInMonth}`).format("YYYY-MM-DD"),
      dailyWage: "",
      dayWorkedPlace: null,
      duration: "",
      employeeId: "",
      endAt: null,
      firstName: "",
      id: "",
      lastName: "",
      notes: "",
      payPerDay: "",
      startAt: null,
      wageFrom: null,
    });
    daysInMonth--;
  }
  return arrDays;
}
