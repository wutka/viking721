package com.wutka.viking721;

/**
 * Copied from: https://github.com/HanWelmer/DasmZ80/tree/master
 */

public class BinaryCode {

    private final String mask;
    private final String mnemonic;

    // Constructor.
    public BinaryCode(String mask, String mnemonic) {
        this.mask = mask;
        this.mnemonic = mnemonic;
    }

    public String getMask() {
        return mask;
    }

    public String getMnemonic() {
        return mnemonic;
    }
}
