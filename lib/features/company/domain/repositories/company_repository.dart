import '../entities/company.dart';

abstract class CompanyRepository {
  List<Company> getCompanies();
  Company? getCompanyById(String id);
}
