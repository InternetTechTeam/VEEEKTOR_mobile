import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/sign_up_page_bloc/sign_up_page_bloc.dart';
import 'package:veeektor/model/auth_form_model.dart';
import 'package:veeektor/model/department_model.dart';
import 'package:veeektor/model/educational_eviroment.dart';
import 'package:veeektor/widgets/text_input_widget.dart';

class SignUpStepper extends StatefulWidget {
  const SignUpStepper({super.key});

  @override
  State<SignUpStepper> createState() => _SignUpStepperState();
}

class _SignUpStepperState extends State<SignUpStepper> {
  int _activeStepIdx = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _patronymicController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _envController = TextEditingController();
  final TextEditingController _depController = TextEditingController();
  DepartmentModel? _selectedDep = null;

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  List<Step> _getSteps() => [
        Step(
          isActive: _activeStepIdx >= 0,
          title: Text(""),
          content: FullnameFormStep(
            nameController: _nameController,
            surnameController: _surnameController,
            patronymicController: _patronymicController,
            formKey: _formKeys[0],
          ),
        ),
        Step(
          isActive: _activeStepIdx >= 1,
          title: Text(""),
          content: AccountStep(
            emailController: _emailController,
            passwordController: _passwordController,
            formKey: _formKeys[1],
          ),
        ),
        Step(
          isActive: _activeStepIdx >= 2,
          title: Text(""),
          content: DepartmentSelectionStep(
            depController: _depController,
            envController: _envController,
            selectedDep: _selectedDep,
          ),
        ),
      ];

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _patronymicController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _envController.dispose();
    _depController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      steps: _getSteps(),
      currentStep: _activeStepIdx,
      onStepContinue: () {
        bool lastStep = _activeStepIdx == _getSteps().length - 1;
        if (lastStep) {
          print(_depController.text);
          print(_selectedDep);
          // TODO: Проверка данных на последней странице
          BlocProvider.of<SignUpPageBloc>(context).add(SignUpPageEvent.signUp(
            form: SignUpFormModel(
              name: _nameController.text,
              surname: _surnameController.text,
              patronymic: _patronymicController.text,
              email: _emailController.text,
              password: _passwordController.text,
              depId: 0,
            ),
          ));
          return;
        }

        if (_formKeys[_activeStepIdx].currentState!.validate()) {
          setState(() {
            _activeStepIdx++;
          });
        }
      },
      onStepCancel: () {
        if (_activeStepIdx > 0) {
          setState(() {
            _activeStepIdx--;
          });
        }
      },
      onStepTapped: (value) {
        if (value < _activeStepIdx) {
          setState(() {
            _activeStepIdx = value;
          });
        } else if (value > _activeStepIdx &&
            _formKeys[_activeStepIdx].currentState!.validate()) {
          setState(() {
            _activeStepIdx = value;
          });
        }
      },
    );
  }
}

class FullnameFormStep extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController patronymicController;
  final GlobalKey<FormState> formKey;

  const FullnameFormStep(
      {super.key,
      required this.nameController,
      required this.patronymicController,
      required this.surnameController,
      required this.formKey});

  @override
  State<FullnameFormStep> createState() => _FullnameFormStepState();
}

class _FullnameFormStepState extends State<FullnameFormStep> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextInputWidget(
            controller: widget.surnameController,
            label: "Фамилия",
            validator: (value) {
              if (value == null || value == "") {
                return "Это поле необходимо заполнить";
              }
              if (value.length < 2) {
                return "Это поле должно содержать более 2ух символов";
              }

              return null;
            },
          ),
          TextInputWidget(
            controller: widget.nameController,
            label: "Имя",
            validator: (value) {
              if (value == null || value == "") {
                return "Это поле необходимо заполнить";
              }
              if (value.length < 2) {
                return "Это поле должно содержать более 2ух символов";
              }

              return null;
            },
          ),
          TextInputWidget(
            controller: widget.patronymicController,
            label: "Отчетство",
            validator: (value) {
              if (value == null || value == "") {
                return "Это поле необходимо заполнить";
              }
              if (value.length < 2) {
                return "Это поле должно содержать более 2ух символов";
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

class AccountStep extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  const AccountStep({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  State<AccountStep> createState() => _AccountStepState();
}

class _AccountStepState extends State<AccountStep> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextInputWidget(
            controller: widget.emailController,
            label: "Email",
            validator: (value) {
              return null;
            },
          ),
          TextInputWidget(
            controller: widget.passwordController,
            label: "Пароль",
            obscureText: true,
            validator: (value) {
              if (value == null || value == "") {
                return "Это поле необходимо заполнить";
              }
              if (value.length < 8) {
                return "Пароль должен быть минимум из 8 символов";
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

class DepartmentSelectionStep extends StatefulWidget {
  final TextEditingController envController;
  final TextEditingController depController;
  DepartmentModel? selectedDep = null;
  DepartmentSelectionStep({
    super.key,
    required this.depController,
    required this.envController,
    required this.selectedDep,
  });

  @override
  State<DepartmentSelectionStep> createState() =>
      _DepartmentSelectionStepState();
}

class _DepartmentSelectionStepState extends State<DepartmentSelectionStep> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpPageBloc, SignUpPageState>(
      builder: (context, state) {
        return Column(
          children: [
            // educational env
            DropdownMenu<EducationalEnviroment>(
              controller: widget.envController,
              dropdownMenuEntries: state.enviroments
                  .map<DropdownMenuEntry<EducationalEnviroment>>(
                    (i) => DropdownMenuEntry<EducationalEnviroment>(
                      value: i,
                      label: i.name,
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                if (value == null || !state.enviroments.contains(value)) {
                  BlocProvider.of<SignUpPageBloc>(context).add(
                      SignUpPageEvent.changeDepDropdownActivity(value: false));
                  return;
                }

                BlocProvider.of<SignUpPageBloc>(context)
                    .add(SignUpPageEvent.loadingDeps(envId: value.id));
              },
            ),
            DropdownMenu<DepartmentModel>(
              controller: widget.depController,
              enabled: state.depDropdownMenuActive,
              dropdownMenuEntries: state.departments
                  .map<DropdownMenuEntry<DepartmentModel>>(
                    (i) => DropdownMenuEntry(
                      value: i,
                      label: i.name,
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                if (value != null && state.departments.contains(value)) {
                  widget.selectedDep = value;
                  return;
                }

                widget.selectedDep = null;
              },
            ),
          ],
        );
      },
    );
  }
}
