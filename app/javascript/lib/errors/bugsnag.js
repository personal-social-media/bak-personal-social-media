import BugsnagPluginReact from '@bugsnag/plugin-react';
import BugsnagReport from '@bugsnag/js';
const apiKey = process.env.BUGSNAG;
import React from 'react';
let ErrorBoundaryComponent;

if (apiKey) {
  BugsnagReport.start({
    apiKey: apiKey,
    plugins: [new BugsnagPluginReact()],
  });
  ErrorBoundaryComponent = BugsnagReport.getPlugin('react').createErrorBoundary(React);
}

export const BugsnagErrorBoundary = ErrorBoundaryComponent;
export const bugsnagApiKey = apiKey;
