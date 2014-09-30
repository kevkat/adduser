Sysadmin scripts
=======

adduser
--
Script to add a user with a temporary password and add all pertinent licensing for our environment

ffkill
--
FFmpeg has a nasty habit of hanging during batch conversions, this script monitors the output directory for a hang. If the conversion file in the most recent directory hasn't changed size in the past second, it's hung. Gets the PID of the ffmpeg process and kills it.
