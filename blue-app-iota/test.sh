gcc src/ternary_store.c tests/test_ternary.c -lm -o test
chmod a+x test
echo "Running ternery test.."
./test
rm test
