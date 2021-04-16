import {decodeBase32} from '../format/decode-base32';
import NodeRSA from 'node-rsa';

export function peerInfoVerification(peerInfo, ipField) {
  /* eslint-disable sort-keys-fix/sort-keys-fix */
  const fields = {
    username: peerInfo.username,
    name: peerInfo.name,
    avatars: peerInfo.avatars,
    ip: peerInfo[ipField],
  };
  /* eslint-enable */
  const fieldsJSON = JSON.stringify(fields);

  const {publicKey, signature} = peerInfo;

  if (!signature) return false;

  const decodedSignature = decodeBase32(signature);
  const pk = new NodeRSA(publicKey);
  return pk.verify(fieldsJSON, decodedSignature);
}
