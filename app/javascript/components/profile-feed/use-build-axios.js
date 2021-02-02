export default function useBuildAxios(peerIp){
  const instance = axios.create({
    baseURL: peerIp + "/api",
    timeout: 1000,
  });
}