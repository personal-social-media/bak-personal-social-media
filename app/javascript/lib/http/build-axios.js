import axios from "axios";
import applyCaseMiddleware from "axios-case-converter";

export function buildProxyAxios(peerId){
  let instance = axios.create({
    baseURL: "/proxy",
  });
  instance = applyCaseMiddleware(instance);
  return instance;
}