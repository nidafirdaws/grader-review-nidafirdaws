CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'



FOUND=`find student-submission -name "ListExamples.java"`
if [[ $FOUND == " " ]]
then 
    echo "ListExamples.java not found"
    exit 1
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

javac student-submission/ListExamples.java

FOUND=`find student-submission -name "ListExamples.class"`
if [[ $FOUND == " " ]]
then 
    echo "ListExamples.class not found"
    exit 1
fi

cp -r student-submission/* grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area
cd grading-area
javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > results.txt



FULLCREDIT=`grep -o OK results.txt` 
FAILED=`grep -o FAILURES results.txt`

if [[ $FULLCREDIT == "OK" ]]
then 
    echo 'Full Credit'
fi 
if [[ $FAILED == "FAILURES" ]]
then 
    echo 'Failures Credit'
fi 