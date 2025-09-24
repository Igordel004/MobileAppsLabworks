part of '../../presentation/home_page/home_page.dart';

typedef OnLikeCallback = void Function(String title, bool isLiked)?;

class _Card extends StatefulWidget {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;
  final List<String> types;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;

  const _Card(
    this.text, {
    this.icon = Icons.ac_unit_outlined,
    required this.descriptionText,
    this.imageUrl,
    required this.types,
    this.onLike,
    this.onTap,
  });

  factory _Card.fromData(
    CardData data, {
    OnLikeCallback onLike,
    VoidCallback? onTap,
  }) => _Card(
    data.text,
    descriptionText: data.descriptionText,
    icon: data.icon,
    imageUrl: data.imageUrl,
    types: data.types,
    onLike: onLike,
    onTap: onTap,
  );

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool isLiked = false;

  String _getFirstSentence(String text) {
    final sentences = text.split(RegExp(r'(?<=[.!?])\s+'));
    return sentences.isNotEmpty ? sentences.first : text;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        constraints: const BoxConstraints(minHeight: 140),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.lightGreen.withValues(alpha: 0.2),
              spreadRadius: 4,
              offset: const Offset(0, 5),
              blurRadius: 8,
            ),
          ],
          color: Colors.grey.withValues(alpha: 0.2),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: SizedBox(
                  height: double.infinity,
                  width: 120,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child:
                            widget.imageUrl != null &&
                                widget.imageUrl!.isNotEmpty
                            ? Image.network(
                                widget.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Placeholder(),
                              )
                            : const Placeholder(),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              widget.types.join(' / '),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.text,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Text(
                              _getFirstSentence(widget.descriptionText),
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.7),
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Icon(widget.icon),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLiked = !isLiked;
                                  });
                                  widget.onLike?.call(widget.text, isLiked);
                                },
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: isLiked
                                      ? const Icon(
                                    Icons.favorite,
                                    color: Colors.redAccent,
                                    key: ValueKey<int>(0),
                                  )
                                      : const Icon(
                                    Icons.favorite_border,
                                    key: ValueKey<int>(1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}