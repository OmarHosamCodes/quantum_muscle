import { initializeApp } from "firebase/app";
import { getStorage, ref, uploadBytesResumable } from "firebase/storage";
const firebaseConfig = {
  apiKey: "AIzaSyDcvMqyGhRQFslglBDWJaSzIDwJiNaTvS0",
  authDomain: "quantum-muscle-dev.firebaseapp.com",
  projectId: "quantum-muscle-dev",
  storageBucket: "quantum-muscle-dev.appspot.com",
  messagingSenderId: "1052229399737",
  appId: "1:1052229399737:web:5f935c91c03e7ca2465768",
};

const app = initializeApp(firebaseConfig);
const storage = getStorage(app);

function uploadFile(file, path) {
  const storageRef = ref(storage, path);
  const bytes = new Uint8Array(file);
  const uploadTask = uploadBytes(storageRef, bytes);
  return uploadTask.snapshot.ref.getDownloadURL();
}
