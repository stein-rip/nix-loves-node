// index.js
const express = require("express");
const sqlite3 = require("sqlite3").verbose();
const app = express();
const port = 3000;
const dbFile = "./database.db";

const db = new sqlite3.Database(dbFile, (err) => {
  if (err) {
    console.error(err.message);
    return;
  }
  console.log("Connected to the SQLite database.");
  db.run("CREATE TABLE IF NOT EXISTS projects(name text)");
});

app.get("/", (req, res) => {
  res.send(`
    <body style="font-family: sans-serif; background-color: #f0f0f0; padding: 2rem;">
      <h1>Hello from your Nix Environment!</h1>
      <p>This app is running inside a fully reproducible shell.</p>
      <p>It's connected to a local <b>${dbFile}</b> file.</p>
    </body>
  `);
});

app.listen(port, () => {
  console.log(`Server listening on http://localhost:${port}`);
});

process.on("SIGINT", () => {
  db.close();
  process.exit();
});
