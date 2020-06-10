package com.sapoon.loginmembservice.common.exception;

public class UnauthorizedException extends Throwable {
    private static final long serialVersionUID = 5171363499855070899L;

    public UnauthorizedException() {
    }

    public UnauthorizedException(String message) {
        super(message);
    }

    public UnauthorizedException(Throwable cause) {
        super(cause);
    }

    public UnauthorizedException(String message, Throwable cause) {
        super(message, cause);
    }
}
