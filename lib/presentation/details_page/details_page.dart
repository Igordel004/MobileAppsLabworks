part of '../../presentation/home_page/home_page.dart';

class DetailsPage extends StatelessWidget {
  final CardData data;

  const DetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.imageUrl != null && data.imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.network(data.imageUrl!),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                data.text,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
              data.descriptionText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
