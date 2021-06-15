const fs = require("fs");
const path = require("path");
const { exec } = require("child_process");

const YAML = require("yaml");

const destination = "../dist";

if (!fs.existsSync(destination)) {
    fs.mkdirSync(destination);
}

exec("swift run generate", (error, stdout, stderr) => {
    if (error) {
        console.error(`exec error: ${error}`);
        return;
    }

    const yaml = YAML.parse(stdout);
    fs.writeFileSync(path.join(destination, "openapi.yml"), YAML.stringify(yaml));
});

