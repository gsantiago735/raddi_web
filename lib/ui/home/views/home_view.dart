import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raddi_web/ui/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/ui/home/widgets/widget.dart';
import 'package:raddi_web/widgets/generic/generic.dart';
import 'package:raddi_web/models/generic/generic_enums.dart';
import 'package:raddi_web/providers/auth_local_provider.dart';
import 'package:raddi_web/core/constants/constants_icons.dart';
import 'package:raddi_web/core/constants/constants_images.dart';
import 'package:raddi_web/ui/authentication/views/login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String routeName = 'home_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _View()),
    );
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => __ViewState();
}

class __ViewState extends State<_View> {
  late GeneralCubit _cubit;

  final double _headerHeight = 140;

  @override
  void initState() {
    _cubit = context.read<GeneralCubit>();

    _cubit.getUser();
    _cubit.getHomeInformation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: _headerHeight,
                child: SvgPicture.asset(ConstantIcons.logo),
              ),
              Expanded(child: _RenderLeftSection()),
            ],
          ),
        ),
        VerticalDivider(width: 0, color: const Color(0xFFE4E4E4)),
        Expanded(
          flex: 6,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: _headerHeight,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<GeneralCubit, GeneralState>(
                        buildWhen: (p, c) => (p.user != c.user),
                        builder: (context, state) {
                          return Text(
                            (state.user?.displayName ?? "").isNotEmpty
                                ? "¡Hola, ${state.user?.displayName}!"
                                : "¡Hola!",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFF11142D),
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            "Bienvenido",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 48,
                              color: Color(0xFF11142D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          ConstantImages.wavingHand,
                          scale: 5,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(child: _RenderCenterSection()),
            ],
          ),
        ),
        VerticalDivider(width: 0, color: const Color(0xFFE4E4E4)),
        Expanded(
            flex: 3,
            child: Column(
              children: [
                SizedBox(
                  height: _headerHeight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<GeneralCubit, GeneralState>(
                          buildWhen: (p, c) => (p.user != c.user),
                          builder: (context, state) {
                            if ((state.user?.photoURL ?? "").isEmpty) {
                              return Icon(Icons.person_rounded,
                                  size: 50, color: Color(0xFF11142D));
                            }
                            return GenericNetworkImage(
                              path: state.user?.photoURL,
                              size: 50,
                              border: 100,
                            );
                          }),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<GeneralCubit, GeneralState>(
                                buildWhen: (p, c) => (p.user != c.user),
                                builder: (context, state) {
                                  return Text(
                                    state.user?.email ?? "N/A",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF11142D),
                                    ),
                                  );
                                }),
                            Text(
                              "Administrador",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF808191),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.logout_rounded),
                        onPressed: () async {
                          await AuthLocalProvider().logOut();
                          if (!context.mounted) return;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              LoginView.routeName,
                              (Route<dynamic> route) => false);
                        },
                      )
                    ],
                  ),
                ),
                Expanded(child: _RenderRightSection()),
              ],
            )),
      ],
    );
  }
}

class _RenderLeftSection extends StatelessWidget {
  const _RenderLeftSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralCubit, GeneralState>(
        buildWhen: (p, c) => (p.stadisticsStatus != c.stadisticsStatus),
        builder: (context, state) {
          switch (state.stadisticsStatus) {
            case WidgetStatus.error:
              return Center(
                  child: Text(
                "Ha ocurrido un error.",
                textAlign: TextAlign.center,
              ));
            case WidgetStatus.loading:
              return Center(child: LoadingIndicator());
            default:
              return ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  children: [
                    StadisticComponent(
                      title: "Usuarios registrados",
                      value: state.stadistics?.general?.dataGeneral?.dataUser
                              ?.totalUserRegister
                              .toString() ??
                          "N/A",
                    ),
                    const SizedBox(height: 14),
                    StadisticComponent(
                      title: "Usuarios por verificar",
                      value: state.stadistics?.general?.dataGeneral?.dataUser
                              ?.usersNotVerified
                              .toString() ??
                          "N/A",
                    ),
                    const SizedBox(height: 14),
                    StadisticComponent(
                      title: "Conductores registrados",
                      value: state.stadistics?.general?.dataGeneral?.dataUbers
                              ?.totalUbersRegister
                              .toString() ??
                          "N/A",
                    ),
                    const SizedBox(height: 14),
                    StadisticComponent(
                      title: "Conductores por verificar",
                      value: state.stadistics?.general?.dataGeneral?.dataUbers
                              ?.ubersNotVerified
                              .toString() ??
                          "N/A",
                    ),
                    const SizedBox(height: 14),
                    StadisticComponent(
                      title: "Conductores en línea",
                      value: state.stadistics?.general?.dataGeneral?.dataUbers
                              ?.ubersOnline
                              .toString() ??
                          "N/A",
                    ),
                    const SizedBox(height: 14),
                    StadisticComponent(
                      title: "Viajes en curso",
                      value: state.stadistics?.general?.dataGeneral?.dataTrips
                              ?.ongoingTrips
                              .toString() ??
                          "N/A",
                    ),
                  ],
                ),
              );
          }
        });
  }
}

class _RenderCenterSection extends StatelessWidget {
  const _RenderCenterSection();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<GeneralCubit, GeneralState>(
      buildWhen: (p, c) => (p.paymentMethodStatus != c.paymentMethodStatus),
      builder: (context, state) {
        switch (state.paymentMethodStatus) {
          case WidgetStatus.error:
            return Center(
                child: Text(
              "Ha ocurrido un error.",
              textAlign: TextAlign.center,
            ));
          case WidgetStatus.loading:
            return Center(child: LoadingIndicator());
          default:
            return ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                children: [
                  CustomLayout(
                    child: WeeklyStadisticComponent(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomLayout(child: PaymentComponent()),
                      ),
                      //const SizedBox(width: 10),
                      //Expanded(
                      //  child: Container(
                      //    height: 200,
                      //    decoration: BoxDecoration(
                      //        color: Colors.red,
                      //        borderRadius:
                      //            BorderRadius.all(Radius.circular(24))),
                      //  ),
                      //),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
        }
      },
    );
  }
}

class _RenderRightSection extends StatelessWidget {
  const _RenderRightSection();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<GeneralCubit, GeneralState>(
      buildWhen: (p, c) => (p.incomeStatus != c.incomeStatus),
      builder: (context, state) {
        switch (state.incomeStatus) {
          case WidgetStatus.error:
            return Center(
                child: Text(
              "Ha ocurrido un error.",
              textAlign: TextAlign.center,
            ));
          case WidgetStatus.loading:
            return Center(child: LoadingIndicator());
          default:
            return ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                children: [
                  CustomLayout(child: IncomeCard()),
                  const SizedBox(height: 40),
                  CustomLayout(
                    child: BarChartTripsComponent(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
        }
      },
    );
  }
}
