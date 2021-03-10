export default function mergeStyles(...styles) {
  return styles.join(' ').replace(/^\s+|\s+$/g, '');
}
