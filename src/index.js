import "./main.css";
import { Elm } from "./Main.elm";
import * as serviceWorker from "./serviceWorker";

var flags = {
  window: {
    width: window.innerWidth,
    height: window.innerHeight
  },
  time: Date.now()
};

var app = Elm.Main.init({
  node: document.getElementById("root"),
  flags: flags
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();

app.ports.toggleBodyNoScroll.subscribe(shouldBePresent => {
  document.body.classList.toggle("no-scroll", shouldBePresent);
});
