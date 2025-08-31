import 'package:flutter/material.dart';

/// Un widget personnalisé affichant une photo d'utilisateur circulaire
/// avec la possibilité de l'agrandir en cliquant dessus.
class CircularUserPhoto extends StatelessWidget {
  /// L'URL de l'image à afficher
  final String imageUrl;

  /// La taille du cercle (diamètre)
  final double size;

  /// Épaisseur de la bordure
  final double borderWidth;

  /// Couleur de la bordure
  final Color borderColor;

  /// Options pour personnaliser le comportement d'agrandissement de l'image
  final bool showFullScreenOnTap;

  /// Image de secours à afficher en cas d'erreur de chargement
  final Widget? placeholder;

  const CircularUserPhoto({
    super.key,
    required this.imageUrl,
    this.size = 100.0,
    this.borderWidth = 2.0,
    this.borderColor = Colors.white,
    this.showFullScreenOnTap = true,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'user-photo-$imageUrl',
      child: GestureDetector(
        onTap: showFullScreenOnTap ? () => _showFullScreenImage(context) : null,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    valueColor: AlwaysStoppedAnimation<Color>(borderColor),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return placeholder ??
                    Center(
                      child: Icon(
                        Icons.person,
                        size: size * 0.6,
                        color: Colors.grey[400],
                      ),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Affiche l'image en plein écran avec une animation fluide
  void _showFullScreenImage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (BuildContext context, _, __) {
          return FullScreenImageView(
            imageUrl: imageUrl,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}

/// Widget pour afficher l'image en plein écran
class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Image agrandie
          Center(
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20.0),
              minScale: 0.5,
              maxScale: 3.0,
              child: Hero(
                tag: 'user-photo-$imageUrl',
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Bouton pour fermer l'image
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Exemple d'utilisation
class ExampleUserPhotoPage extends StatelessWidget {
  const ExampleUserPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo de Profil"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exemple d'utilisation avec une image de profil
            CircularUserPhoto(
              imageUrl: 'https://i.pravatar.cc/300',
              size: 120.0,
              borderWidth: 3.0,
              borderColor: Colors.blue,
            ),

            SizedBox(height: 20),

            // Exemple avec une image personnalisée et une taille différente
            CircularUserPhoto(
              imageUrl: 'https://i.pravatar.cc/300?img=33',
              size: 80.0,
              borderColor: Colors.green,
            ),

            SizedBox(height: 20),

            // Texte explicatif
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Tapez sur l'image pour l'agrandir",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
