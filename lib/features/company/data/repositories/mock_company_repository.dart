import '../../domain/entities/company.dart';
import '../../domain/repositories/company_repository.dart';
import '../datasources/mock_companies_data.dart';

class MockCompanyRepository implements CompanyRepository {
  const MockCompanyRepository();

  @override
  List<Company> getCompanies() => mockCompaniesData;

  @override
  Company? getCompanyById(String id) {
    for (final company in mockCompaniesData) {
      if (company.id == id) {
        return company;
      }
    }
    return null;
  }
}
