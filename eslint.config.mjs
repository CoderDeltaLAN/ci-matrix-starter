import js from "@eslint/js";
import tseslint from "typescript-eslint";

export default [
  {
    ignores: [
      "node_modules/**",
      "dist/**",
      ".venv/**",
      "coverage/**",
      "_ci_logs/**",
      "**/*.mjs",
    ],
  },
  js.configs.recommended,
  ...tseslint.configs.recommended,
  {
    files: ["src/**/*.ts"],
    ...tseslint.configs.recommendedTypeChecked[0],
    languageOptions: { parserOptions: { project: "./tsconfig.json" } },
    rules: {},
  },
];
