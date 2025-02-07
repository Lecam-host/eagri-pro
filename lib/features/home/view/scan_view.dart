import 'dart:io';
import 'dart:developer';
import 'package:eagri_pro/common/components/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../core/utils/router/routes.dart';

class ScanView extends StatefulWidget {
  final Function(String)? onScan;
  final String? invoiceNumber;
  const ScanView({Key? key, this.onScan, this.invoiceNumber}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  Barcode? result;
  QRViewController? controller;
  bool? status = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildQrView(context),
                    if (result != null)
                      Positioned(
                        bottom: 40,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Code scanné avec succès',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (result == null)
                        Text(
                          'Scannez le QR code de la facture',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      if (result != null) ...[
                        const SizedBox(height: 16),
                        ButtonCustom(
                          label: "Voir les détails",
                          onPressed: () {
                            if (widget.onScan != null) {
                              widget.onScan!(result!.code!);
                              context.pop();
                            } else {
                              context.pushReplacementNamed(
                                Routes.detailsOrders.name,
                                extra: {
                                  'code': result!.code,
                                  'invoiceNumber': widget.invoiceNumber
                                },
                              );
                            }
                          },
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                        ),
                        const SizedBox(height: 8),
                        ButtonCustom(
                          label: "Scanner un nouveau code",
                          onPressed: () async {
                            await controller?.resumeCamera();
                            setState(() {
                              result = null;
                            });
                          },
                          textColor: Colors.white,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 20,
            top: 100,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      await controller?.toggleFlash();
                      setState(() {
                        controller?.getFlashStatus().then((value) {
                          status = value;
                        });
                      });
                    },
                    icon: Icon(
                      status! ? Icons.flash_off : Icons.flash_on,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  Container(width: 1, height: 24, color: Colors.grey[300]),
                  IconButton(
                    onPressed: () async {
                      await controller?.flipCamera();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.flip_camera_ios,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderRadius: 12,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        // Pause la caméra immédiatement après la détection
        await controller.pauseCamera();
      } else {
        await controller.resumeCamera();
        setState(() {
          result = null;
        });
      }
      setState(() {
        result = scanData;
        if (widget.onScan != null) {
          widget.onScan!(scanData.code!);
          Navigator.pop(context);
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
