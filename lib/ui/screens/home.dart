import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/gif.dart';
import 'package:morphosis_flutter_demo/non_ui/providers/viewmodels/home_viewmodel.dart';
import 'package:morphosis_flutter_demo/ui/widgets/gif_grid.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchTextField = TextEditingController();

  @override
  void dispose() {
    _searchTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoSearchTextField(
              controller: _searchTextField,
              onSubmitted: (_) => Provider.of<HomeViewModel>(
                context,
                listen: false,
              ).searchGIFs(_searchTextField.text),
            ),
            Expanded(
              child: Consumer<HomeViewModel>(
                builder: (_, HomeViewModel viewModel, __) {
                  final List<GIF>? gifs = viewModel.gifs;

                  if (!viewModel.isSearching && gifs == null) {
                    return const Center(
                        child: Text('Something went wrong. Try again.'));
                  }

                  return Stack(
                    children: <Widget>[
                      if (gifs != null) GIFGrid(gifs: gifs),
                      if (viewModel.isSearching)
                        const Center(child: CircularProgressIndicator()),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
