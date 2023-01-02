const _localStorageKey = "data.projects";
export const getProjectsFromLocalStorage = () => {
  const restString = window.localStorage.getItem(_localStorageKey);
  let restArray = [];
  try {
    restArray = restString !== null ? JSON.parse(restString) : "{}";
  } catch (ex) {
    console.log(ex);
  }
  return restArray;
};

export const setProjectsToLocalStorage = (rest: Array<any>) => {
  window.localStorage.setItem(_localStorageKey, JSON.stringify(rest));
};
