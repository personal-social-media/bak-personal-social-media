import deepCamelcase from 'deep-camelcase-keys';

export default function camelize(obj) {
  return deepCamelcase(obj);
}

