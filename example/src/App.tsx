import { Text, View, StyleSheet, TextInput } from 'react-native';
import { sha256, sha1 } from 'react-native-sha256';
import { useCallback, useEffect, useState } from 'react';

export default function App() {
  const [text, setText] = useState('Test');
  const [sha256Result, setSha256Result] = useState('');
  const [sha1Result, setSha1Result] = useState('');

  const calcHashes = useCallback((subject: string) => {
    setText(subject);
    const sha256Hash = sha256(subject);
    setSha256Result(sha256Hash);
    const sha1Hash = sha1(subject);
    setSha1Result(sha1Hash);
  }, []);

  useEffect(() => {
    calcHashes(text);
  }, [calcHashes, text]);

  return (
    <View style={styles.container}>
      <Text style={styles.welcome}>Welcome to Hashes</Text>

      <TextInput
        style={styles.textInput}
        onChangeText={(v) => calcHashes(v)}
        value={text}
      />

      <Text style={styles.label}>SHA 256:</Text>
      <Text style={styles.hash}>{sha256Result}</Text>

      <Text style={styles.label}>SHA 1:</Text>
      <Text style={styles.hash}>{sha1Result}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  textInput: { height: 40, width: 200, borderColor: 'gray', borderWidth: 1 },
  label: {
    marginTop: 24,
    fontWeight: 'bold',
  },

  hash: {
    width: '80%',
  },
});
