/* global module */
/* eslint-env node */
"use strict";

module.exports.fuzz = (data) => {
  try {
    JSON.parse(data.toString());
  } catch {
    // ignore
  }
};
