export function addDataToNotifications(notification) {
  return {
    ...notification,
    ...getUrlAndMessageForNotification(notification),
  };
}

function getUrlAndMessageForNotification({notificationType, subjectId, subjectType, metadata}) {
  const result = {};
  result.message = getMessage(notificationType, subjectId, subjectType, metadata);
  result.url = getUrl(notificationType, subjectId, subjectType, metadata);
  result.icon = getIcon(notificationType, subjectId, subjectType, metadata);
  return result;
}

function getMessage(notificationType, subjectId, subjectType, metadata) {
  if (notificationType === 'profile_welcome') return 'Welcome to your personal social media';
}

function getUrl(notificationType, subjectId, subjectType, metadata) {
  if (notificationType === 'profile_welcome') return '/sessions/profile';
}

function getIcon(notificationType, subjectId, subjectType, metadata) {
  if (notificationType === 'profile_welcome') return 'fa fa-trophy text-yellow-400 bg-red-500';
}