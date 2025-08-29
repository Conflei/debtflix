import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user.dart';
import '../../../data/models/employment_data.dart';
import '../../../data/repositories/user_repository.dart';

class UserViewModel extends StateNotifier<User?> {
  final UserRepository _repository;

  UserViewModel(this._repository) : super(null) {
    _loadUser();
  }

  // Form state
  String _employer = '';
  int _annualIncome = 0;
  EmploymentType _employmentType = EmploymentType.fullTime;
  String _jobTitle = '';
  PayFrequency _payFrequency = PayFrequency.weekly;
  String _employerAddress = '';
  int _yearsAtEmployer = 0;
  int _monthsAtEmployer = 0;
  String _nextPayDate = '';
  bool _isDirectDeposit = false;

  // Getters for form fields
  String get employer => _employer;
  int get annualIncome => _annualIncome;
  EmploymentType get employmentType => _employmentType;
  String get jobTitle => _jobTitle;
  PayFrequency get payFrequency => _payFrequency;
  String get employerAddress => _employerAddress;
  int get yearsAtEmployer => _yearsAtEmployer;
  int get monthsAtEmployer => _monthsAtEmployer;
  String get nextPayDate => _nextPayDate;
  bool get isDirectDeposit => _isDirectDeposit;

  // Load user data and populate form
  Future<void> _loadUser() async {
    final user = _repository.getUser();
    if (user != null) {
      state = user;
      _populateFormFromUser(user);
    }
  }

  // Populate form fields with user data
  void _populateFormFromUser(User user) {
    _employer = user.employmentData.employer;
    _annualIncome = user.employmentData.annualIncome;
    _employmentType = user.employmentData.employmentType;
    _jobTitle = user.employmentData.jobTitle;
    _payFrequency = user.employmentData.payFrequency;
    _employerAddress = user.employmentData.employerAddress;
    _yearsAtEmployer = user.employmentData.yearsAtEmployer;
    _monthsAtEmployer = user.employmentData.monthsAtEmployer;
    _nextPayDate = user.employmentData.nextPayDate;
    _isDirectDeposit = user.employmentData.isDirectDeposit;
  }

  // Update form fields
  void updateEmployer(String value) {
    _employer = value;
    state = state?.copyWith(
      employmentData: state!.employmentData.copyWith(employer: value),
    );
  }

  void updateAnnualIncome(int value) {
    _annualIncome = value;
    state = state?.copyWith(
      employmentData: state!.employmentData.copyWith(annualIncome: value),
    );
  }

  void updateEmploymentType(EmploymentType value) {
    _employmentType = value;
    state = state?.copyWith(
      employmentData: state!.employmentData.copyWith(employmentType: value),
    );
  }

  void updateJobTitle(String value) {
    _jobTitle = value;
    state = state?.copyWith(
      employmentData: state!.employmentData.copyWith(jobTitle: value),
    );
  }

  void updatePayFrequency(PayFrequency value) {
    _payFrequency = value;
    state = state?.copyWith(
      employmentData: state!.employmentData.copyWith(payFrequency: value),
    );
  }

  void updateEmployerAddress(String value) {
    _employerAddress = value;
    state = state?.copyWith(
      employmentData: state!.employmentData.copyWith(employerAddress: value),
    );
  }

  void updateYearsAtEmployer(int value) {
    _yearsAtEmployer = value;
    state = state?.copyWith(
      employmentData: state!.employmentData.copyWith(yearsAtEmployer: value),
    );
  }

  void updateMonthsAtEmployer(int value) {
    _monthsAtEmployer = value;
    state = state?.copyWith(
      employmentData: state!.employmentData.copyWith(monthsAtEmployer: value),
    );
  }

  void updateNextPayDate(String value) {
    _nextPayDate = value;
    state = state?.copyWith(
      employmentData: state!.employmentData.copyWith(nextPayDate: value),
    );
  }

  void updateIsDirectDeposit(bool value) {
    _isDirectDeposit = value;
    state = state?.copyWith(
      employmentData: state!.employmentData.copyWith(isDirectDeposit: value),
    );
  }

  // Save user data
  Future<void> saveUser() async {
    if (state != null) {
      await _repository.saveUser(state!);
    }
  }

  // Create new user
  Future<void> createUser(User user) async {
    await _repository.saveUser(user);
    state = user;
    _populateFormFromUser(user);
  }

  // Update existing user
  Future<void> updateUser(User user) async {
    await _repository.saveUser(user);
    state = user;
    _populateFormFromUser(user);
  }
}
