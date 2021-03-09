import {BugsnagErrorBoundary, bugsnagApiKey} from '../../lib/errors/bugsnag';

export default function Bugsnag({children}) {
  if (!bugsnagApiKey) return children;

  function onError({errors}) {
    errors.forEach((error) => {
      console.error(error);
    });
  }

  return (
    <BugsnagErrorBoundary onError={onError}>
      {children}
    </BugsnagErrorBoundary>
  );
}
