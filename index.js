const fs = require("fs");
const { exec } = require("child_process");

const YAML = require("yaml");

if (!fs.existsSync("dist")) {
    fs.mkdirSync("dist");
}

exec("swift run generate", (error, stdout, stderr) => {
    if (error) {
        console.error(`exec error: ${error}`);
        return;
    }

    const yaml = YAML.parse(stdout);
    fs.writeFileSync("dist/openapi.yml", YAML.stringify(yaml));
});

