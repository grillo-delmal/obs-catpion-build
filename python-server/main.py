import os
import liblo
from easygoogletranslate import EasyGoogleTranslate
from threading import Lock

import obsws_python as obs

cl = obs.ReqClient(host='localhost', port=4455, timeout=3)

class CaptionTextThread():
    def __init__(self):
        self.server = liblo.ServerThread(5050)
        self.translator_es = EasyGoogleTranslate(
            source_language='en',
            target_language='es',
            timeout=10)
        self.translator_ja = EasyGoogleTranslate(
            source_language='en',
            target_language='ja',
            timeout=10)

        self.lock = Lock()
        self.caption = ""
        self.last_translated = None
        self.last_translation_es = ""
        self.last_translation_ja = ""

        self.server.add_method("/obs-catpion", None, self.test_handler)
    
    def test_handler(self, path, args, types, src):
        print("RECEIVED")
        global cl
        if path.startswith("/obs-catpion"):
            with self.lock:
                self.caption = args[0]
                print(args[0])
                if(self.last_translated != args[0]):
                    self.last_translated = args[0]
                    self.last_translation_es = self.translator_es.translate(self.last_translated)
                    self.last_translation_ja = self.translator_ja.translate(self.last_translated)
                # TRY SENDING
                cl.set_input_settings("sp_tr", {"text": self.last_translation_es}, True)
                cl.set_input_settings("jp_tr", {"text": self.last_translation_ja}, True)

    def start(self):
        self.server.start()

    def stop(self):
        self.server.stop()


if __name__ == "__main__":
    import time
    server = CaptionTextThread()

    server.start()
    while True:
        time.sleep(1)
    server.stop()