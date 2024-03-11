import 'package:example/ui/shared/app_colors.dart';
import 'package:example/ui/shared/ui_helpers.dart';
import 'package:example/ui/widgets/dumb_widgets/app_button.dart';
import 'package:example/ui/widgets/dumb_widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends HookWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = useTextEditingController();
    var password = useTextEditingController();

    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        key: Key('login_view'),
        backgroundColor: kcDarkGreyColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getResponsiveHorizontalSpaceMedium(context)),
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                SizedBox(height: 160),
                Text(
                  'Welcome to TestSweets',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text('Login with your details below'),
                verticalSpaceLarge,
                SizedBox(
                  child: InputField(
                    controller: email,
                    placeholder: 'Enter your Email',
                  ),
                ),
                verticalSpaceSmall,
                SizedBox(
                  child: InputField(
                    controller: password,
                    placeholder: 'Enter your Password',
                  ),
                ),
                verticalSpaceSmall,
                if (true)
                  SizedBox(
                    child: GestureDetector(
                      onTap: () => viewModel.navigateToForgotPassword(),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                verticalSpaceMedium,
                if (viewModel.hasValidationError)
                  GestureDetector(
                    onTap: () => viewModel.navigateToForgotPassword(),
                    child: Column(
                      children: <Widget>[
                        Text(
                          viewModel.validationMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                        verticalSpaceMedium,
                      ],
                    ),
                  ),
                SizedBox(
                  child: AppButton(
                    title: 'Login',
                    busy: viewModel.isBusy,
                    onPressed: () => viewModel.login(
                      userName: email.text,
                      password: password.text,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    verticalSpaceMedium,
                    GestureDetector(
                        onTap: () => viewModel.navigateToSignUp(),
                        child: Text('Don\'t have an account? Sign up'))
                  ],
                ),
                SizedBox(height: 150),
                Text(
                  'Not convinced? Read on 👇',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                    'We have built the best way for Flutter teams to write automated tests. With our no-code solution you never have to worry about stale code for tests. Our solution makes tests less brittle and allows you to modify existing tests with ease. You don\'t need to maintain any code, or go through many hours of setup. '),
                SizedBox(height: 20),
                Text(
                    'The best part is that developers don\'t have to write the automated tests anymore. Right now, all the responsibility for quality assurance automation falls on the developer. Even in teams that have dedicated quality assurance, this is still the case. Either the testers need to spend many hours learning the basics of programming, or there\'s no automated quality assurance. The reason being, developers do not have the time to do it. Or at least that\'s the excuse I\'ve heard through my career.'),
                SizedBox(height: 20),
                Text(
                    'So if you want to join the revolution, get started below.'),
                SizedBox(height: 30),
                SizedBox(
                  child: AppButton(
                    title: 'Get Started',
                    busy: viewModel.isBusy,
                    onPressed: viewModel.toggleNewsletterUI,
                  ),
                ),
                if (viewModel.showNewsletterUI) ...[
                  SizedBox(height: 60),
                  Text(
                    'Still not convinced? 🤔',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                      'Give us your email and we\'ll send you free weekly guides to help you automate your quality assurance for free, without using our product.'),
                  SizedBox(height: 30),
                  SizedBox(
                    child: InputField(
                      controller: email,
                      placeholder: 'Enter your Email',
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    child: AppButton(
                      color: Colors.white,
                      title: 'Get Weekly Info',
                      busy: viewModel.isBusy,
                      onPressed: () => print('Does nothing, just for show'),
                    ),
                  ),
                ],
                SizedBox(height: 60),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
