#!/usr/bin/env node
import { ESLint } from "eslint";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path/posix";

try {
    const shutdown_handler_api = (await import("../node_modules/flux-shutdown-handler-api/src/Adapter/Api/ShutdownHandlerApi.mjs")).ShutdownHandlerApi.new();
    await shutdown_handler_api.init();
    await shutdown_handler_api.getShutdownHandler();

    const __dirname = dirname(fileURLToPath(import.meta.url));

    const eslint = new ESLint({
        cwd: join(__dirname, ".."),
        errorOnUnmatchedPattern: false,
        extensions: [
            ".cjs",
            ".js",
            ".json",
            ".mjs"
        ],
        globInputPaths: false,
        overrideConfigFile: join(__dirname, "..", ".eslintrc.json"),
        useEslintrc: false
    });

    const result = (await eslint.loadFormatter()).format(await eslint.lintFiles(process.cwd()));

    console.log(result);

    if (result.length > 0) {
        process.exit(1);
    }
} catch (error) {
    console.error(error);

    process.exit(1);
}
