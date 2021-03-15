import {decodeBase32} from '../format/decode-base32';
import NodeRSA from 'node-rsa';

export function peerInfoVerification(peerInfo, ipField) {
  const fields = {
    avatars: peerInfo.avatars,
    ip: peerInfo[ipField],
    name: peerInfo.name,
    username: peerInfo.username,
  };
  const fieldsJSON = JSON.stringify(fields);

  const {publicKey, signature} = peerInfo;

  if (!signature) return false;

  const decodedSignature = decodeBase32(signature);
  const pk = new NodeRSA(publicKey);
  return pk.verify(fieldsJSON, decodedSignature);
}
