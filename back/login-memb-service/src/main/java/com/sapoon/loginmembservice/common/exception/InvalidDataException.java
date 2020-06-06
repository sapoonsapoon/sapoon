package com.sapoon.loginmembservice.common.exception;

public class InvalidDataException extends Exception {

    private static final long serialVersionUID = 5171363499855070899L;

    public InvalidDataException() {
    }

    public InvalidDataException(String message) {
        super(message);
    }

    public InvalidDataException(Throwable cause) {
        super(cause);
    }

    public InvalidDataException(String message, Throwable cause) {
        super(message, cause);
    }

}
