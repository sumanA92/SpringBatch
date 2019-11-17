#!/bin/sh

# POST-COMMIT HOOK
#
# The post-commit hook is invoked after a commit.  Subversion runs
# this hook by invoking a program (script, executable, binary, etc.)
# named 'post-commit' (for which this file is a template) with the 
# following ordered arguments:
#
#   [1] REPOS-PATH   (the path to this repository)
#   [2] REV          (the number of the revision just committed)
#   [3] TXN-NAME     (the name of the transaction that has become REV)
#
# The default working directory for the invocation is undefined, so
# the program should set one explicitly if it cares.
#
# Because the commit has already completed and cannot be undone,
# the exit code of the hook program is ignored.  The hook program
# can use the 'svnlook' utility to help it examine the
# newly-committed tree.
#
# On a Unix system, the normal procedure is to have 'post-commit'
# invoke other programs to do the real work, though it may do the
# work itself too.
#
# Note that 'post-commit' must be executable by the user(s) who will
# invoke it (typically the user httpd runs as), and that user must
# have filesystem-level permission to access the repository.
#
# On a Windows system, you should name the hook program
# 'post-commit.bat' or 'post-commit.exe',
# but the basic idea is the same.
# 
# The hook program typically does not inherit the environment of
# its parent process.  For example, a common problem is for the
# PATH environment variable to not be set to its usual value, so
# that subprograms fail to launch unless invoked via absolute path.
# If you're having unexpected problems with a hook program, the
# culprit may be unusual (or missing) environment variables.
# 
# Here is an example hook script, for a Unix /bin/sh interpreter.
# For more examples and pre-written hooks, see those in
# the Subversion repository at
# http://svn.apache.org/repos/asf/subversion/trunk/tools/hook-scripts/ and
# http://svn.apache.org/repos/asf/subversion/trunk/contrib/hook-scripts/



SET REPOS=%1
SET REV=%2
echo %REPOS% %REV% >> %REPOS%/commit.txt
#E:\curl-7.67.0_4-win64-mingw\curl-7.67.0-win64-mingw\bin\curl  -u SumanReddy:SumanReddy http://localhost:8080/job/maven-build-job/build?token=token_to_build

#@ECHO OFF
#REM *************************************************************
#REM * this sets the arguments supplied by Subversion            *
#REM *************************************************************
#SET REPOS=%1
#SET REV=%2
#
#REM *************************************************************
#REM * define directory paths                                    *
#REM * you *must* add any paths for command line tools you plan  *
#REM * since SVN does not include the Windows %PATH% environment *
#REM * variable for security reasons.                            *
#REM *                                                           *
#REM * DIR  - the current hooks directory                        *
#REM * PATH - a user set path of where executables are located   *
#REM *                                                           *
#REM *************************************************************
#SET DIR=%REPOS%/hooks
#REM *************************************************************
#REM * make sure to add the path to the SendEmail executable     *
#REM *************************************************************
#SET PATH=%PATH%;%DIR%
#
#REM *************************************************************
#REM * define the path to the working copy of your code          *
#REM *                                                           *
#REM * the default working_copy folder would be:                 *
#REM * file:///%REPOS%                                           *
#REM *************************************************************
#SET WORKING_COPY=file:///%REPOS%
#
#REM *************************************************************
#REM * define e-mail parameters                                  *
#REM *************************************************************
#SET SITENAME=My Code Base
#SET SMTP_SERVER=smtp.gmail.com
#SET EMAIL_TO=suman.annapureddy@gmail.com
#SET EMAIL_FROM=suman.annapureddy@gmail.com
#SET USER_NAME=suman.annapureddy@gmail.com
#SET PWD=il0veindi@
#SET SUBJECT=SVN Update - %SITENAME% - rev %REV% - %REPOS%
#
#REM *************************************************************
#REM * update the local working copy                             *
#REM * this will sync the new changes to your servers copy       *
#REM *************************************************************
#svn update %WORKING_COPY%
#
#REM *************************************************************
#REM * generate the header to use for the e-mail message         *
#REM *************************************************************
#ECHO The following changes were made to the code: > %DIR%/email.txt
#ECHO. >> %DIR%/email.txt
#
#REM *************************************************************
#REM * dump the log of changes to the e-mail message             *
#REM *************************************************************
#svn log %WORKING_COPY% -v -r "%REV%" >> %DIR%/email.txt
#
#REM *************************************************************
#REM * dump the diff changes to the e-mail message               *
#REM *                                                           *
#REM * WARNING: Generates tons of output                         *
#REM *                                                           *
#REM * NOTE: this is optional, you can remove this information   *
#REM *       if you do not want a verbose message of changes     *
#REM *************************************************************
#svn diff %WORKING_COPY% -c "%REV%" --no-diff-deleted >> %DIR%/email.txt
#
#REM *************************************************************
#REM * send the e-mail message to the user                       *
#REM *                                                           *
#REM * NOTE: to create a SendEmail.log file, append:             *
#REM *                                                           *
#REM *        -l %DIR%/SendEmail.log                             *
#REM *                                                           *
#REM *       at the end of the line below.                       *
#REM *************************************************************
#sendEmail -s %SMTP_SERVER%:587 -t %EMAIL_TO% -f %EMAIL_FROM% -u "%SUBJECT%" -xu %USER_NAME% -xp %PWD% -o tls=yes -o message-file=%DIR%/email.txt -l %DIR%/SendEmail.log
#
#
#
#
#SET REPOS=%1
#SET REV=%2
#
#FOR /f "tokens=*" %%a IN (
#'svnlook uuid %REPOS%'
#) DO (
#SET UUID=%%a
#)
#
#FOR /f "tokens=*" %%b IN (
#'svnlook changed --revision %REV% %REPOS%'
#) DO (
#SET POST=%%b
#)
#echo %POST% %UUID% >> %REPOS%/commit.txt
#
#E:\curl-7.67.0_4-win64-mingw\curl-7.67.0-win64-mingw\bin\curl ^
#	-u SumanReddy:1179eaaa1435ae2e34b5dc26218c26358d
#    --header="Content-Type:text/plain;charset=UTF-8" ^
#    --post-data="%POST%" ^
#    --output-document="-" ^
#    --timeout=2 ^
#    http://localhost:8080/jenkins/subversion/%UUID%/notifyCommit?rev=%REV%