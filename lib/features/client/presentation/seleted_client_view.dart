import 'dart:async';
import 'package:eagri_pro/common/components/custom_text_field.dart';
import 'package:eagri_pro/common/widgets/message_banner.dart';
import 'package:eagri_pro/features/client/data/models/client_model.dart';
import 'package:eagri_pro/features/client/presentation/cubit/client_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../common/widgets/app_bar_custom.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/utils/enum.dart';
import '../../../core/utils/router/routes.dart';
import '../../../generated/locale_keys.g.dart';

class SeletedClientView extends StatefulWidget {
  const SeletedClientView({super.key});

  @override
  State<SeletedClientView> createState() => _SeletedClientViewState();
}

class _SeletedClientViewState extends State<SeletedClientView> {
  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.length > 9) {
        context.read<ClientCubit>().searchClients(value);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(title: LocaleKeys.select_a_customer.tr()),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomTextField(
              onChanged: _onSearchChanged,
              prefixIcon: Icons.search,
              placeholder: LocaleKeys.search_client.tr(),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<ClientCubit, ClientState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.status == Status.error) {
                    return Center(
                      child: MessageBanner(
                          message: state.message ?? '',
                          type: MessageType.error),
                    );
                  }
                  if (state.status == Status.success && state.clients.isEmpty) {
                    return Center(
                      child: Text(LocaleKeys.no_client_found.tr()),
                    );
                  }
                  return ListView.separated(
                    itemCount: state.clients.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final client = state.clients[index];
                      return InkWell(
                          onTap: () {
                            context.read<ClientCubit>().selectClient(client);
                            context.pushNamed(Routes.dasboardClient.path,
                                extra: {"client": client});
                          },
                          child: ClientCard(client: client));
                    },
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

class ClientCard extends StatelessWidget {
  const ClientCard({
    super.key,
    required this.client,
  });

  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorConstants.primaryColor.withAlpha(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${client.user!.firstName!} ${client.user!.lastName!}',
                    style: Theme.of(context).textTheme.titleMedium),
                Text(client.user!.phone!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
