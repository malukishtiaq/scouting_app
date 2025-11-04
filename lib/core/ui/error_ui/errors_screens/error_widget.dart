import 'package:flutter/material.dart';
import 'package:scouting_app/core/common/extensions/localization_extension.dart';
import 'package:scouting_app/core/common/extensions/logger_extension.dart';

import '../../../constants/app/app_constants.dart';
import '../../../errors/app_errors.dart';
import 'build_error_screen.dart';

part 'account_not_verified_error_screen/account_not_verified_error_screen.dart';
part 'bad_request_error_screen/bad_request_error_screen_widget.dart';
part 'cancel_error_screen/cancel_error_screen.dart';
part 'conflict_error_screen/conflict_error_screen.dart';
part 'connection_error_screen/connection_error_screen_widget.dart';
part 'custom_error_screen/custom_error_screen_widget.dart';
part 'forbidden_error_screen/forbidden_error_screen_widget.dart';
part 'format_error_screen/format_error_screen.dart';
part 'guest_error_screen/guest_error_screen.dart';
part 'internal_server_error_screen/internal_server_error_screen_widget.dart';
part 'internal_server_with_data_error_screen/internal_server_with_data_error_screen.dart';
part 'login_required_error_screen/login_required_error_screen.dart';
part 'net_error_screen/net_error_screen.dart';
part 'not_found_error_screen/not_found_error_screen_widget.dart';
part 'response_error_screen/response_error_screen.dart';
part 'screen_not_implemented_error/screen_not_implemented_error_widget.dart';
part 'socket_error_screen/socket_error_screen.dart';
part 'time_out_error_screen.dart/time_out_error_screen_widget.dart';
part 'unauthorized_error_screen/unauthorized_error_screen_widget.dart';
part 'unexpected_error_screen/unexpected_error_screen_widget.dart';
part 'unknown_error_screen/unknown_error_screen.dart';

class ErrorScreenWidget extends StatelessWidget {
  final AppErrors error;
  final VoidCallback callback;
  final bool disableRetryButton;
  final String? backTitle;

  const ErrorScreenWidget({
    super.key,
    required this.error,
    required this.callback,
    this.backTitle,
    this.disableRetryButton = false,
  });

  @override
  Widget build(BuildContext context) {
    error.runtimeType.toString().logD;

    Column? errorWidget;
    if (backTitle != null) {
      errorWidget = Column(
        children: [
          Container(
            height: 150,
            // margin: EdgeInsets.only(
            //   top: ScreenUtil().statusBarHeight,
            // ),
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: [
                ButtonTheme(
                  minWidth: 0,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 45,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          backTitle!,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 40),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }

    final errorResWidget = error.map(
      connectionError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            ConnectionErrorScreenWidget(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return ConnectionErrorScreenWidget(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      internalServerError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            InternalServerErrorScreenWidget(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
        } else {
          return InternalServerErrorScreenWidget(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      internalServerWithDataError: (error) {
        if (errorWidget != null) {
          errorWidget.children.add(
            InternalServerWithDataErrorScreen(
              errorCode: error.errorCode,
              message: error.message,
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
        } else {
          return InternalServerWithDataErrorScreen(
            errorCode: error.errorCode,
            message: error.message,
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      accountNotVerifiedError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            const AccountNotVerifiedErrorScreen(),
          );
        } else {
          return const AccountNotVerifiedErrorScreen();
        }
      },
      badRequestError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(BadRequestErrorScreenWidget(
            message: error.message,
            callback: callback,
          ));
          return errorWidget;
        } else {
          return BadRequestErrorScreenWidget(
            message: error.message,
            callback: callback,
          );
        }
      },
      cancelError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            CancelErrorScreen(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return CancelErrorScreen(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      conflictError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            ConflictErrorScreen(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return ConflictErrorScreen(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      customError: (error) {
        if (errorWidget != null) {
          errorWidget.children.add(
            CustomErrorScreenWidget(
              message: error.message,
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return CustomErrorScreenWidget(
            message: error.message,
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      forbiddenError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(const ForbiddenErrorScreenWidget());
          return errorWidget;
        } else {
          return const ForbiddenErrorScreenWidget();
        }
      },
      formatError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            FormatErrorScreen(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return FormatErrorScreen(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      loginRequiredError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            LoginRequiredErrorScreen(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return LoginRequiredErrorScreen(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      netError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            NetErrorScreen(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return NetErrorScreen(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      notFoundError: (error) {
        if (errorWidget != null) {
          errorWidget.children.add(NotFoundErrorScreenWidget(
            callback: callback,
            disableRetryButton: disableRetryButton,
            url: error.requestedUrlPath,
          ));
          return errorWidget;
        } else {
          return NotFoundErrorScreenWidget(
            callback: callback,
            disableRetryButton: disableRetryButton,
            url: error.requestedUrlPath,
          );
        }
      },
      responseError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            ResponseErrorScreen(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return ResponseErrorScreen(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      screenNotImplementedError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            ScreenNotImplementedErrorWidget(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return ScreenNotImplementedErrorWidget(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      socketError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            SocketErrorScreen(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return SocketErrorScreen(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      timeoutError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            TimeOutErrorScreenWidget(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return TimeOutErrorScreenWidget(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
      unauthorizedError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(const UnauthorizedErrorScreenWidget());
          return errorWidget;
        } else {
          return const UnauthorizedErrorScreenWidget();
        }
      },
      unknownError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            UnknownErrorScreen(
              callback: callback,
              disableRetryButton: disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return UnknownErrorScreen(
            callback: callback,
            disableRetryButton: disableRetryButton,
          );
        }
      },
    );

    if (errorResWidget != null) {
      return errorResWidget;
    }

    if (errorWidget != null) {
      errorWidget.children.add(
        UnexpectedErrorScreenWidget(
          callback: callback,
          disableRetryButton: disableRetryButton,
        ),
      );
    } else {
      return UnexpectedErrorScreenWidget(
        callback: callback,
        disableRetryButton: disableRetryButton,
      );
    }
    return UnexpectedErrorScreenWidget(
      callback: callback,
      disableRetryButton: disableRetryButton,
    );
  }
}
