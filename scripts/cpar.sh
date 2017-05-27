#!/bin/bash
display_usage() {
  echo "\nUsage: sh $0 <your-msg>\n"
}

if [ "$#" -ne 1 ]
then
  display_usage
  exit 1
else
  TheMsg=$1
fi

wait_jobs() {
  JobBatchSize=$1 # Pass in $1 as the parallel batch size.

  JobCounter=$((JobCounter + 1))
  if ((JobCounter >= JobBatchSize)); then
    for job in `jobs -p `; do
      wait $job
      ExitStatus=$?
      echo "Job ID: $job ($ExitStatus)"
      if [ $ExitStatus -ne 0 ]; then
        let "FAIL=FAIL+1"
      fi
    done

    if [ "$FAIL" == "0" ];
    then
      JobCounter=0
    else
      echo "Some job failed!"
      exit 2
    fi
  fi
}

#----------------------------------------#
#-------------- User Code ---------------#
#----------------------------------------#

a_job() {
  sleep $(( (RANDOM % 15 ) + 1 ))
}

TotalNumberOfJobs=66
MaxJobsInParallel=7
JobCounter=0
FAIL=0
for ((i=0; i<$TotalNumberOfJobs; i++)); do
  a_job &
  echo "Launch Process ID: $! ($TheMsg)"
  wait_jobs $MaxJobsInParallel # The number of jobs being launched in parallel
done

# Handle the last batch when TotalNumberOfJobs is not divible by MaxJobsInParallel
wait_jobs 0
