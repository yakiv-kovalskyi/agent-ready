(function () {
  var root = document.documentElement;
  try { var s = localStorage.getItem("ar-theme"); if (s) root.setAttribute("data-theme", s); } catch (e) {}
  window.__toggleTheme = function () {
    var cur = root.getAttribute("data-theme") ||
      (matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light");
    var next = cur === "dark" ? "light" : "dark";
    root.setAttribute("data-theme", next);
    try { localStorage.setItem("ar-theme", next); } catch (e) {}
  };
})();
