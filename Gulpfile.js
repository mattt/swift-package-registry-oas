const fs = require("fs");
const { exec } = require("child_process");
const { series, watch } = require("gulp");
const YAML = require("yaml");

function specification(cb) {
  exec("swift run generate", (error, stdout, stderr) => {
    if (error) {
      console.error(`exec error: ${error}`);
      return;
    }

    const yaml = YAML.parse(stdout);

    if (!fs.existsSync("dist")) {
      fs.mkdirSync("dist");
    }
    fs.writeFileSync("dist/openapi.yml", YAML.stringify(yaml));

    cb();
  });
}

function documentation(cb) {
  exec(
    "npx redoc-cli bundle dist/openapi.yml --output dist/index.html",
    (error, stdout, stderr) => {
      if (error) {
        console.error(`exec error: ${error}`);
        return;
      }

      cb();
    }
  );
}

exports.default = series(specification, documentation);
