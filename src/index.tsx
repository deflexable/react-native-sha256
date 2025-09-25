import Sha256 from './NativeRNSha256';

export function sha256(data: string) {
  try {
    return Sha256.sha256(data);
  } catch (e: any) {
    return e.message;
  }
}

export function sha256Bytes(data: any[]) {
  try {
    return Sha256.sha256Bytes(data);
  } catch (e: any) {
    return e.message;
  }
}

export function sha1(data: string) {
  try {
    return Sha256.sha1(data);
  } catch (e: any) {
    return e.message;
  }
}

export function sha1Bytes(data: any[]) {
  try {
    return Sha256.sha1Bytes(data);
  } catch (e: any) {
    return e.message;
  }
}
