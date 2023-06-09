import 'package:bms/core/models/company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bms/core/models/company.dart';

class CompanyService {
  final String? uid;

  CompanyService({required this.uid});

  final CollectionReference companyCollection =
      FirebaseFirestore.instance.collection('company');

  Stream<Company> get companyData {
    return companyCollection.doc(this.uid).snapshots().map(_companydata);
  }

  Future updateCompanyRecord(
      {String? upiAddress,
      String? companyName,
      String? phoneNumber,
      String? gstNumber,
      String? registeredAddress}) async {
    return await companyCollection.doc(this.uid).set(
      {
        'upi_address': upiAddress,
        'name': companyName,
        'phonenumber': phoneNumber,
        'gstnumber': gstNumber,
        'address': registeredAddress,
      },

      // merge: true
    );
  }

  Company _companydata(DocumentSnapshot snapshot) {
    Map companyData = snapshot.data as Map;

    if (companyData != null) {
      return Company(
        address: companyData['address'] ?? '',
        // booksFrom: ,
        // corporateidentityNumber: ,
        countryName: companyData['countryname'] ?? '',
        // currencyName: ,
        // currencySymbol: ,
        email: companyData['email'] ?? '',
        formalName: companyData['basicompanyformalname'] ?? '',
        gstNumber: companyData['gstnumber'] ?? '',
        // guid: ,
        // incometaxNumber: ,
        // interstatestNumber: ,
        // name: ,
        // ownerName: ,
        // phoneNumber: ,
        pincode: companyData['pincode'] ?? '',
        // startingFrom: ,
        stateName: companyData['statename'] ?? '',
        hasLogo: companyData['restat_has_logo'] ?? '',
        lastEntryDate: companyData['lastentrydate']?.toDate() ?? null,
        lastSyncedAt: companyData['last_synced_at']?.toDate() ?? null,
      );
    } else {
      return Company(
        address: '',
        countryName: '',
        email: '',
        formalName: '',
        gstNumber: '',
        pincode: '',
        stateName: '',
        hasLogo: '',
      );
    }
  }
}
