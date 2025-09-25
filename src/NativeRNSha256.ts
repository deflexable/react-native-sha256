import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  sha1: (input: string) => string;
  sha1Bytes: (input: any[]) => string;
  sha256: (input: string) => string;
  sha256Bytes: (input: any[]) => string;
}

export default TurboModuleRegistry.getEnforcing<Spec>('RNSha256');
