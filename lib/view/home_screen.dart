import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_1/models/book_model.dart';
import 'package:task_1/view_models/bloc_books/books_bloc.dart';
import 'package:task_1/view_models/cubit/calender_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.8;
    return Scaffold(
      appBar: AppBar(title: const Text('Projects'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SearchBar(
              hintText: 'Search books',
              onChanged: (value) {
                final trimmedValue = value.trim();
                if (trimmedValue.isNotEmpty) {
                  context.read<BooksBloc>().add(
                    SearchBooksEvent(query: trimmedValue),
                  );
                }
              },

              backgroundColor: WidgetStateColor.resolveWith(
                (states) => Colors.white,
              ),
              elevation: WidgetStateProperty.resolveWith((states) => 0.5),
              shape: WidgetStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              trailing: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, color: Colors.blue),
                ),
              ],
            ),

            const SizedBox(height: 10),

            BlocBuilder<CalenderCubit, CalenderState>(
              builder: (context, state) {
                late final DateTime selectedDate;

                if (state is CalenderLoaded) {
                  selectedDate = state.selectedDate;
                } else {
                  selectedDate = DateTime.now();
                }
                return GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      context.read<CalenderCubit>().changeDate(pickedDate);
                    }
                  },
                  child: Card(
                    elevation: 0.5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            BlocBuilder<BooksBloc, BooksState>(
              builder: (context, state) {
                if (state is BooksLoading) {
                  return SizedBox(
                    height: height,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is BooksError) {
                  return SizedBox(
                    height: height,
                    child: Center(child: Text(state.error)),
                  );
                }
                if (state is BooksInitial) {
                  return SizedBox(
                    height: height,
                    child: Center(child: Text('No books')),
                  );
                }
                final books = (state as BooksLoaded).bookModel.results;

                return ListView.builder(
                  itemCount: books.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return _cardWidget(book);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Card _cardWidget(Result book) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    book.title ?? 'No book name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Badge(
                  backgroundColor: Colors.blue.shade100,
                  label: Text(
                    'Processing',
                    style: TextStyle(color: Colors.blue),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                ),
              ],
            ),

            subtitle: Row(
              spacing: 8,
              children: [
                _tileDateBuilder(
                  text: 'March 09, 2025',
                  color: Colors.blue,
                  icon: Icons.calendar_today_outlined,
                ),
                _tileDateBuilder(
                  text: 'March 21, 2025',
                  color: Colors.red,
                  icon: Icons.flag_outlined,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Wedding',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          // fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    Text.rich(
                      TextSpan(
                        text: 'Progress ',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 91, 91, 91),
                        ),
                        children: [
                          TextSpan(
                            text: '62%',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(5),
                  value: .6,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return CircleAvatar(radius: 18, backgroundColor: Colors.grey);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _tileDateBuilder({
    required String text,
    required Color color,
    required IconData icon,
  }) {
    return Row(
      spacing: 5,
      children: [
        Icon(icon, size: 16, color: color),
        Text(text, style: TextStyle(color: color, fontSize: 12)),
      ],
    );
  }
}
