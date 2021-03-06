PHP_ARG_WITH(facedetect, for facedetect support, [  --with-facedetect     Enable facedetect support])

if test "$PHP_FACEDETECT" != "no"; then
  AC_PATH_PROG(PKG_CONFIG, pkg-config, no)
  AC_MSG_CHECKING(for opencv)
  if test -x "$PKG_CONFIG" && $PKG_CONFIG --exists opencv; then
    CV_INCLUDE=`$PKG_CONFIG opencv --variable=includedir_new`
    CV_LIBRARY=`$PKG_CONFIG opencv --libs`
    CV_VERSION=`$PKG_CONFIG opencv --modversion`
    if $PKG_CONFIG opencv --atleast-version=2.2.0 ; then
      AC_MSG_RESULT($CV_VERSION)
    else
      AC_MSG_ERROR(opencv version is too old)
    fi
    PHP_EVAL_LIBLINE($CV_LIBRARY, FACEDETECT_SHARED_LIBADD)
    PHP_ADD_INCLUDE($CV_INCLUDE)
  else
    AC_MSG_ERROR(Please reinstall opencv)
  fi

  PHP_SUBST(FACEDETECT_SHARED_LIBADD)
  AC_DEFINE(HAVE_FACEDETECT, 1, [ ])
  PHP_NEW_EXTENSION(facedetect, facedetect.c, $ext_shared)
fi

