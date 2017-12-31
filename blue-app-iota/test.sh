gcc src/ternary_store.c tests/test_ternary.c -lm -o test
chmod a+x test
echo "Running ternary test.."
./test
rm test
