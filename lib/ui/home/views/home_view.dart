import 'package:flutter/material.dart';
import 'package:raddi_web/ui/cubit/cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/ui/home/widgets/widget.dart';
import 'package:raddi_web/widgets/generic/generic.dart';
import 'package:raddi_web/models/generic/generic_enums.dart';
import 'package:raddi_web/core/constants/constants_icons.dart';

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

  final double centerSection = 64.0;

  @override
  void initState() {
    _cubit = context.read<GeneralCubit>();

    _cubit.getIncome();
    _cubit.getStadistic();
    _cubit.getPaymentStadistics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
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
              Padding(
                padding: EdgeInsets.only(
                    top: 30, left: centerSection, right: centerSection),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hola!",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF11142D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Bienvenido 👋",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 48,
                        color: Color(0xFF11142D),
                        fontWeight: FontWeight.w600,
                      ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SvgPicture.asset(ConstantIcons.logo),
                ),
                Expanded(
                    child: _RenderRightSection(
                  padding: centerSection,
                )),
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
              return Text("Error");
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
    return BlocBuilder<GeneralCubit, GeneralState>(
      buildWhen: (p, c) => (p.stadisticsStatus != c.stadisticsStatus),
      builder: (context, state) {
        switch (state.stadisticsStatus) {
          case WidgetStatus.error:
            return Text("error");
          case WidgetStatus.loading:
            return Center(child: LoadingIndicator());
          default:
            return ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                children: [
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
        }
      },
    );
  }
}

class _RenderRightSection extends StatelessWidget {
  const _RenderRightSection({required this.padding});

  final double padding;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: padding),
        children: [
          Expanded(
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
