enum GRANEL_TYPE { NEW, CONTRACT }

class Granel {
  String contract;
  String count;
  String nameBusiness;
  String email;
  String phoneNumber;
  String contact;
  bool isContract;

  Granel({
    this.contract,
    this.count,
    this.nameBusiness,
    this.email,
    this.phoneNumber,
    this.contact,
    this.isContract,
  });

  Map<String, String> getGranelMail() {
    Map<String, String> json;
    if (!this.isContract) {
      json = {
        "nombre": "",
        "contacto": "",
        "contrato": this.contract,
        "cantidad": this.count,
        "telefono": "",
        "email": "",
      };
    } else {
      json = {
        "nombre": this.nameBusiness,
        "contacto": this.contact,
        "contrato": "",
        "cantidad": this.count,
        "telefono": this.phoneNumber,
        "email": this.email,
      };
    }
    return json;
  }
}
