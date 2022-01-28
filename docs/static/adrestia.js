// Keep anchor #links on the same page, when they would otherwise redirect to
// the page's <base href>. Ref: https://stackoverflow.com/q/8108836
(function() {
  function anchorHrefHash(el) {
    if (el.tagName.toLowerCase() === "a") {
      var href = el.getAttribute("href");
      if (href && href.indexOf("#") === 0) {
        return el.getAttribute("href");
      }
    }
  }

  function fixLink(el) {
    var hash = anchorHrefHash(el);
    if (hash) {
      el.href = location.pathname + hash;
    }
    return el;
  }

  // Adjust href for all existing links.
  document.addEventListener("DOMContentLoaded", function() {
    const es = document.getElementsByTagName("a");
    for (var i = 0; i < es.length; i++) {
      fixLink(es[i]);
    }
  });

  document.addEventListener("click", function(ev) {
    // Adjust href for dynamically added links - when they are clicked.
    var el = fixLink(ev.target);
    // Special case for ema live server: handle the click
    if (el && !!window.connected) {
      if (el.hash && el.pathname === window.location.pathname) {
        window.location.hash = el.hash;
        ev.stopPropagation();
        ev.preventDefault();
      }
    }
  });
})();

function mermaidClick(nodeId) {
  if (nodeId) {
    window.location.hash = "#" + nodeId;
  }
}
