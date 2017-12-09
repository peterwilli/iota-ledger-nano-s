gcc src/ternery_store.c tests/test_ternery.c -lm -o test
chmod a+x test
echo "Running ternery test.."
./test
rm test
