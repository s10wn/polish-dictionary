List<int> numbers = List.generate(15, (index) => index);

Future<void> fetchFiveMore() async {
  await Future.delayed(
    const Duration(seconds: 1),
  );
  numbers.sublist(numbers.length - 5).addAll(
        List.generate(5, (index) => index + numbers.length),
      );
}
